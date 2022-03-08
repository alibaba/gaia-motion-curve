// Copyright (c) 2022, Alibaba Group Holding Limited;
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


#import "CALayer+GaiaMotionCurve.h"
#import "GMCHelper.h"
#import "GMCModel+Internal.h"
#import <objc/runtime.h>


static const void *kGMCAnimationKeys = &kGMCAnimationKeys;

@implementation CALayer (GaiaMotionCurve)

- (NSString *)gmc_animateWithGMCModels:(NSArray<GMCModel *> *)models
                            completion:(GMCCompletionBlock)completion {
    return [self gmc_animateWithGMCModels:models animationKey:nil completion:completion];
}


- (NSString *)gmc_animateWithGMCModels:(NSArray<GMCModel *> *)models
                          animationKey:(NSString *)animationKey
                            completion:(GMCCompletionBlock)completion {
    if (models == nil || models.count <= 0) {
        return nil;
    }
    NSMutableArray *animations = [NSMutableArray array];
    NSString *uuidString = animationKey;

    if (self.gmc_animationKeys == nil) {
        self.gmc_animationKeys = [NSMutableDictionary dictionary];
    }

    int durationIndex = 0;
    CFTimeInterval currentDuration = 0;
    for (int i = 0; i < models.count; i++) {
        GMCModel *model = [models objectAtIndex:i];
        NSArray *values = [GMCHelper valuesByCurveModel:model];
        if (values == nil || values.count <= 0) {
            continue;
        }
        
        if ([model.keyPath hasPrefix:@"bounds"]) {
          [self addGMCAnimation:model];
        }

        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:model.keyPath];
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.delegate = self;
        animation.beginTime = model.delay;
        animation.duration = model.duration;
        animation.repeatCount = model.repeatCount;
        animation.autoreverses = model.autoReverse;
        [animation setValues:values];
        [animations addObject:animation];

        CFTimeInterval tmpDuration = (MAX(model.repeatCount, 1) + (model.autoReverse ? 1 : 0)) * (model.duration) + model.delay;
        if (tmpDuration > currentDuration) {
            durationIndex = i;
            currentDuration = tmpDuration;
        }
    }

    NSMutableArray *animationKeys = (animationKey == nil ? [NSMutableArray array] : self.gmc_animationKeys[animationKey]);
    for (int i = 0; i < animations.count; i++) {
        CAKeyframeAnimation *animation = [animations objectAtIndex:i];
        NSString *identifier = [[NSUUID UUID] UUIDString];
        [animation setValue:identifier forKey:@"gmc_identifier"];
        if (i == durationIndex) {
            if (completion != nil) {
                [animation setValue:completion forKey:@"gmc_completion_block"];
            }
            if (uuidString == nil) {
                uuidString = identifier;
            }
        }
        [animationKeys addObject:identifier];
        [self addAnimation:animation forKey:identifier];
    }

    [self.gmc_animationKeys setObject:animationKeys forKey:uuidString];

    return uuidString;
}

- (void)addGMCAnimation:(GMCModel *)model {
    UIView *associatedView = (UIView *) self.delegate;
    CGRect fromRect = [model.fromValue CGRectValue];
    CGRect toRect = [model.toValue CGRectValue];
    if ([associatedView isKindOfClass:[UIView class]] &&
            associatedView.autoresizesSubviews &&
            associatedView.subviews.count > 0) {
        for (UIView *view in associatedView.subviews) {
            UIViewAutoresizing mask = view.autoresizingMask;
            if (mask != UIViewAutoresizingNone) {
                CGFloat dx = toRect.size.width - fromRect.size.width;
                CGFloat dy = toRect.size.height - fromRect.size.height;

                dx /= ((mask & UIViewAutoresizingFlexibleLeftMargin) ? 1 : 0) +
                        ((mask & UIViewAutoresizingFlexibleWidth) ? 1 : 0) +
                        ((mask & UIViewAutoresizingFlexibleRightMargin) ? 1 : 0);
                dy /= ((mask & UIViewAutoresizingFlexibleTopMargin) ? 1 : 0) +
                        ((mask & UIViewAutoresizingFlexibleHeight) ? 1 : 0) +
                        ((mask & UIViewAutoresizingFlexibleBottomMargin) ? 1 : 0);

                CGFloat scale = [UIScreen mainScreen].scale;
                if ((fabs(dx) < 1.0f / scale) && (fabs(dy) < 1.0f / scale)) {
                    return;
                }
                CGRect bounds = view.bounds;
                bounds.size.width += (mask & UIViewAutoresizingFlexibleWidth) ? dx : 0;
                bounds.size.height +=
                        (mask & UIViewAutoresizingFlexibleHeight) ? dy : 0;
                CGFloat originX = 0;
                if (mask & UIViewAutoresizingFlexibleLeftMargin) {
                    originX = dx;
                } else if (mask & UIViewAutoresizingFlexibleWidth) {
                    originX = dx * view.layer.anchorPoint.x;
                };
                CGFloat originY = 0;
                if (mask & UIViewAutoresizingFlexibleTopMargin) {
                    originY = dy;
                } else if (mask & UIViewAutoresizingFlexibleHeight) {
                    originY = dy * view.layer.anchorPoint.y;
                };
                NSMutableArray *array = [[NSMutableArray alloc] init];
                if (!CGRectEqualToRect(view.bounds, bounds)) {
                    GMCModel *model1 = [GMCModel
                            modelWithKeyPath:@"bounds"
                                    duration:model.duration
                                       delay:model.delay
                                   curveType:model.curveType
                                   argsModel:model.argsModel
                                   fromValue:[NSValue valueWithCGRect:view.bounds]
                                     toValue:[NSValue valueWithCGRect:bounds]];
                    [array addObject:model1];
                }
                CGPoint toPoint = CGPointMake(view.layer.position.x + originX,
                        view.layer.position.y + originY);
                if (!CGPointEqualToPoint(view.layer.position, toPoint)) {
                    GMCModel *model2 = [GMCModel
                            modelWithKeyPath:@"position"
                                    duration:model.duration
                                       delay:model.delay
                                   curveType:model.curveType
                                   argsModel:model.argsModel
                                   fromValue:[NSValue
                                           valueWithCGPoint:view.layer
                                                   .position]
                                     toValue:[NSValue valueWithCGPoint:toPoint]];
                    [array addObject:model2];
                }
                if ([array count] > 0) {
                    [view.layer gmc_animateWithGMCModels:array completion:^(BOOL finished) {
                    }];
                }
            }
        }
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([anim isKindOfClass:[CAKeyframeAnimation class]] && [anim valueForKey:@"gmc_identifier"]) {
        CAKeyframeAnimation *keyAnimation = (CAKeyframeAnimation *) anim;

        if (flag) {
            NSArray *values = [keyAnimation values];
            if (values && values.count > 0) {
                if (!keyAnimation.autoreverses) {
                    [self setValue:[values lastObject] forKeyPath:keyAnimation.keyPath];
                } else {
                    [self setValue:[values firstObject] forKeyPath:keyAnimation.keyPath];
                }
            }
        }


        NSString *animationID = [anim valueForKey:@"gmc_identifier"];


        [self removeAnimationForKey:animationID];

        [self.gmc_animationKeys removeObjectForKey:animationID];


        GMCCompletionBlock block = [keyAnimation valueForKey:@"gmc_completion_block"];
        if (block) {
            block(flag);
        }
    }
}


- (NSString *)gmc_serialAnimationWithGMCModels:(NSArray<GMCModel *> *)models
                                    completion:(GMCCompletionBlock)completion {
    NSString *animationKey = [[NSUUID UUID] UUIDString];
    if (self.gmc_animationKeys == nil) {
        self.gmc_animationKeys = [NSMutableDictionary dictionary];
    }
    [self serialAnimationWithGMCModels:models currentIndex:0 animationKey:animationKey completion:completion];
    return animationKey;
}


- (void)serialAnimationWithGMCModels:(NSArray<GMCModel *> *)models
                        currentIndex:(NSInteger)currentIndex
                        animationKey:(NSString *)animationKey
                          completion:(GMCCompletionBlock)completion {
    NSInteger count = models.count;
    GMCModel *model = [models objectAtIndex:currentIndex];
    [self.gmc_animationKeys setObject:[NSMutableArray array] forKey:animationKey];
    GMCWeakSelf(self)
    [self gmc_animateWithGMCModels:@[model] animationKey:animationKey completion:^(BOOL finished) {
        if (finished) {
            NSInteger index = currentIndex;
            index++;
            GMCStrongSelf(self);
            if (index < count) {
                [self serialAnimationWithGMCModels:models currentIndex:index animationKey:animationKey completion:completion];
            } else {
                if (completion != nil) {
                    completion(finished);
                }
            }
        } else {
            if (completion != nil) {
                completion(finished);
            }
        }
    }];

}


- (void)gmc_cancelAnimationWithID:(NSString *)animationID {
    if (animationID.length > 0) {
        if (self.gmc_animationKeys) {
            if (self.gmc_animationKeys[animationID] != nil) {
                NSArray *animations = self.gmc_animationKeys[animationID];
                for (NSUInteger i = 0; i < animations.count; i++) {
                    [self removeAnimationForKey:animations[i]];
                }
                [self removeAnimationForKey:animationID];
            } else {
                [self removeAnimationForKey:animationID];
            }
        } else {
            [self removeAnimationForKey:animationID];
        }
        [self.gmc_animationKeys removeObjectForKey:animationID];
    }
}


- (void)gmc_cancelAllAnimations {
    if (self.gmc_animationKeys != nil) {
        for (NSString *animationID in self.gmc_animationKeys) {
            [self gmc_cancelAnimationWithID:animationID];
        }
        [self.gmc_animationKeys removeAllObjects];
    }
}


- (void)setGmc_animationKeys:(NSMutableDictionary *)gmc_animationKeys {
    objc_setAssociatedObject(self, &kGMCAnimationKeys, gmc_animationKeys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)gmc_animationKeys {
    return objc_getAssociatedObject(self, &kGMCAnimationKeys);
}

@end
