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

#import "GMCHelper.h"
#import "GMCModel.h"
#import "GMCModel+Internal.h"
#import "GMCFunctions.h"

@implementation GMCHelper

+ (NSArray *)valuesByCurveModel:(GMCModel *)model {
    return [self valuesByCurveModel:model valueCount:60];
}


+ (NSValue *)valueByCurveModel:(GMCModel *)model progressPercent:(CGFloat)percent {
    CGFloat tc = 60;
    NSMutableArray *values = [NSMutableArray array];
    CGFloat t = 0.0;
    CGFloat dt = 1.0 / (tc - 1);
    CGFloat count = MAX(1, round(tc * percent));
    if (model.fromValue == nil || model.toValue == nil ||
            strcmp(model.fromValue.objCType, model.toValue.objCType) != 0) {
    } else {
        if (strcmp(model.fromValue.objCType, @encode(CGFloat)) == 0) {
            CGFloat fromValue = [model.fromValue gmc_CGFloatValue];
            CGFloat toValue = [model.toValue gmc_CGFloatValue];
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat delta = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat value = fromValue + delta * (toValue - fromValue);
                [values addObject:[NSValue gmc_valueWithCGFloat:(CGFloat) value]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGPoint)) == 0) {
            CGPoint fromPoint = [model.fromValue CGPointValue];
            CGPoint toPoint = [model.toValue CGPointValue];
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat delta = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat x = fromPoint.x + delta * (toPoint.x - fromPoint.x);
                CGFloat y = fromPoint.y + delta * (toPoint.y - fromPoint.y);
                [values addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGSize)) == 0) {
            CGSize fromSize = [model.fromValue CGSizeValue];
            CGSize toSize = [model.toValue CGSizeValue];
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat delta = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat width = fromSize.width + delta * (toSize.width - fromSize.width);
                CGFloat height = fromSize.height + delta * (toSize.height - fromSize.height);
                [values addObject:[NSValue valueWithCGSize:CGSizeMake(width, height)]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGRect)) == 0) {
            CGRect fromRect = [model.fromValue CGRectValue];
            CGRect toRect = [model.toValue CGRectValue];
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat delta = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat x = fromRect.origin.x + delta * (toRect.origin.x - fromRect.origin.x);
                CGFloat y = fromRect.origin.y + delta * (toRect.origin.y - fromRect.origin.y);
                CGFloat width = fromRect.size.width + delta * (toRect.size.width - fromRect.size.width);
                CGFloat height = fromRect.size.height + delta * (toRect.size.height - fromRect.size.height);
                [values addObject:[NSValue
                        valueWithCGRect:CGRectMake(x, y, width, height)]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGAffineTransform)) ==
                0) {
            CGAffineTransform fromTransform =
                    [model.fromValue CGAffineTransformValue];
            CGAffineTransform toTransform = [model.toValue CGAffineTransformValue];
            CGPoint fromT = CGPointMake(fromTransform.tx, fromTransform.ty);
            CGPoint toT = CGPointMake(toTransform.tx, toTransform.ty);
            CGFloat fromS = hypot(fromTransform.a, fromTransform.c);
            CGFloat toS = hypot(toTransform.a, toTransform.c);
            CGFloat fromR = atan2(fromTransform.c, fromTransform.a);
            CGFloat toR = atan2(toTransform.c, toTransform.a);
            CGFloat deltaR = toR - fromR;
            if (deltaR < -M_PI) {
                deltaR += (2 * M_PI);
            } else if (deltaR > M_PI) {
                deltaR -= (2 * M_PI);
            }
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat inter = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat translateX =
                        fromT.x + inter * (toT.x - fromT.x);
                CGFloat translateY =
                        fromT.y + inter * (toT.y - fromT.y);
                CGFloat scale = fromS + inter * (toS - fromS);
                CGFloat rotate = fromR + inter * deltaR;
                CGAffineTransform affineTransform = CGAffineTransformMake(
                        scale * cos(rotate), -scale * sin(rotate), scale * sin(rotate),
                        scale * cos(rotate), translateX, translateY);
                CATransform3D transform =
                        CATransform3DMakeAffineTransform(affineTransform);
                [values addObject:[NSValue valueWithCATransform3D:transform]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGColorRef)) == 0) {
            UIColor *fromColor = [UIColor colorWithCGColor:[model.fromValue gmc_CGColorValue]];
            UIColor *toColor = [UIColor colorWithCGColor:[model.toValue gmc_CGColorValue]];
            if (fromColor && toColor) {
                if ([fromColor isKindOfClass:[UIColor class]] &&
                        [toColor isKindOfClass:[UIColor class]]) {
                    CGFloat fromRed, fromGreen, fromBlue, fromAlpha;
                    CGFloat toRed, toGreen, toBlue, toAlpha;
                    [fromColor getRed:&fromRed
                                green:&fromGreen
                                 blue:&fromBlue
                                alpha:&fromAlpha];
                    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
                    CGFloat lastValue = 0.0f;
                    CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
                    for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                        CGFloat delta = [GMCHelper computeCurvedStep:t
                                                           lastValue:&lastValue
                                                        lastVelocity:&lastVelocity
                                                                type:model.curveType
                                                               model:model.argsModel];
                        CGFloat red = fromRed + delta * (toRed - fromRed);
                        CGFloat green = fromGreen + delta * (toGreen - fromGreen);
                        CGFloat blue = fromBlue + delta * (toBlue - fromBlue);
                        CGFloat alpha = fromAlpha + delta * (toAlpha - fromAlpha);
                        [values addObject:(id) [UIColor colorWithRed:red
                                                               green:green
                                                                blue:blue
                                                               alpha:alpha]
                                .CGColor];
                    }
                }
            }
        }
    }

    return [values lastObject];
}

+ (NSArray *)valuesByCurveModel:(GMCModel *)model valueCount:(NSInteger)count {
    NSMutableArray *values = [NSMutableArray array];
    CGFloat t = 0.0;
    CGFloat dt = 1.0 / (count - 1);

    if (model.fromValue == nil || model.toValue == nil ||
            strcmp(model.fromValue.objCType, model.toValue.objCType) != 0) {
    } else {
        if (strcmp(model.fromValue.objCType, @encode(CGFloat)) == 0) {
            CGFloat fromValue = [model.fromValue gmc_CGFloatValue];
            CGFloat toValue = [model.toValue gmc_CGFloatValue];
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat delta = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat value = fromValue + delta * (toValue - fromValue);
                [values addObject:[NSNumber numberWithFloat:(CGFloat) value]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGPoint)) == 0) {
            CGPoint fromPoint = [model.fromValue CGPointValue];
            CGPoint toPoint = [model.toValue CGPointValue];
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat delta = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat x = fromPoint.x + delta * (toPoint.x - fromPoint.x);
                CGFloat y = fromPoint.y + delta * (toPoint.y - fromPoint.y);
                [values addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGSize)) == 0) {
            CGSize fromSize = [model.fromValue CGSizeValue];
            CGSize toSize = [model.toValue CGSizeValue];
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat delta = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat width = fromSize.width + delta * (toSize.width - fromSize.width);
                CGFloat height = fromSize.height + delta * (toSize.height - fromSize.height);
                [values addObject:[NSValue valueWithCGSize:CGSizeMake(width, height)]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGRect)) == 0) {
            CGRect fromRect = [model.fromValue CGRectValue];
            CGRect toRect = [model.toValue CGRectValue];
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat delta = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat x = fromRect.origin.x + delta * (toRect.origin.x - fromRect.origin.x);
                CGFloat y = fromRect.origin.y + delta * (toRect.origin.y - fromRect.origin.y);
                CGFloat width = fromRect.size.width + delta * (toRect.size.width - fromRect.size.width);
                CGFloat height = fromRect.size.height + delta * (toRect.size.height - fromRect.size.height);
                [values addObject:[NSValue
                        valueWithCGRect:CGRectMake(x, y, width, height)]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGAffineTransform)) ==
                0) {
            CGAffineTransform fromTransform =
                    [model.fromValue CGAffineTransformValue];
            CGAffineTransform toTransform = [model.toValue CGAffineTransformValue];
            CGPoint fromT = CGPointMake(fromTransform.tx, fromTransform.ty);
            CGPoint toT = CGPointMake(toTransform.tx, toTransform.ty);
            CGFloat fromS = hypot(fromTransform.a, fromTransform.c);
            CGFloat toS = hypot(toTransform.a, toTransform.c);
            CGFloat fromR = atan2(fromTransform.c, fromTransform.a);
            CGFloat toR = atan2(toTransform.c, toTransform.a);
            CGFloat deltaR = toR - fromR;
            if (deltaR < -M_PI) {
                deltaR += (2 * M_PI);
            } else if (deltaR > M_PI) {
                deltaR -= (2 * M_PI);
            }
            CGFloat lastValue = 0.0f;
            CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
            for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                CGFloat inter = [GMCHelper computeCurvedStep:t
                                                   lastValue:&lastValue
                                                lastVelocity:&lastVelocity
                                                        type:model.curveType
                                                       model:model.argsModel];
                CGFloat translateX =
                        fromT.x + inter * (toT.x - fromT.x);
                CGFloat translateY =
                        fromT.y + inter * (toT.y - fromT.y);
                CGFloat scale = fromS + inter * (toS - fromS);
                CGFloat rotate = fromR + inter * deltaR;
                CGAffineTransform affineTransform = CGAffineTransformMake(
                        scale * cos(rotate), -scale * sin(rotate), scale * sin(rotate),
                        scale * cos(rotate), translateX, translateY);
                CATransform3D transform =
                        CATransform3DMakeAffineTransform(affineTransform);
                [values addObject:[NSValue valueWithCATransform3D:transform]];
            }
        } else if (strcmp(model.fromValue.objCType, @encode(CGColorRef)) == 0) {
            UIColor *fromColor = [UIColor colorWithCGColor:[model.fromValue gmc_CGColorValue]];
            UIColor *toColor = [UIColor colorWithCGColor:[model.toValue gmc_CGColorValue]];
            if (fromColor && toColor) {
                if ([fromColor isKindOfClass:[UIColor class]] &&
                        [toColor isKindOfClass:[UIColor class]]) {
                    CGFloat fromRed, fromGreen, fromBlue, fromAlpha;
                    CGFloat toRed, toGreen, toBlue, toAlpha;
                    [fromColor getRed:&fromRed
                                green:&fromGreen
                                 blue:&fromBlue
                                alpha:&fromAlpha];
                    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
                    CGFloat lastValue = 0.0f;
                    CGFloat lastVelocity = (model.curveType == GMCCurveTypeSpring && [model.argsModel isKindOfClass:[GMCRK4SpringArgsModel class]]) ? [(GMCRK4SpringArgsModel *) model.argsModel velocity] : 0.0f;
                    for (NSUInteger frame = 0; frame < count; ++frame, t += dt) {
                        CGFloat delta = [GMCHelper computeCurvedStep:t
                                                           lastValue:&lastValue
                                                        lastVelocity:&lastVelocity
                                                                type:model.curveType
                                                               model:model.argsModel];
                        CGFloat red = fromRed + delta * (toRed - fromRed);
                        CGFloat green = fromGreen + delta * (toGreen - fromGreen);
                        CGFloat blue = fromBlue + delta * (toBlue - fromBlue);
                        CGFloat alpha = fromAlpha + delta * (toAlpha - fromAlpha);
                        [values addObject:(id) [UIColor colorWithRed:red
                                                               green:green
                                                                blue:blue
                                                               alpha:alpha]
                                .CGColor];
                    }
                }
            }
        }
    }

    return values;
}

+ (CGFloat)computeCurvedStep:(CGFloat)step
                   lastValue:(CGFloat *)lastValue
                lastVelocity:(CGFloat *)lastVelocity
                        type:(GMCCurveType)curveType
                       model:(GMCBaseArgsModel *)argsModel {
    CGFloat value;
    if (curveType == GMCCurveTypeOvershoot) {
        GMCAnticipateArgsModel *overshootArgsModel = (GMCAnticipateArgsModel *) argsModel;
        value = gmc_overshoot_curve(step, overshootArgsModel.d, overshootArgsModel.x1, overshootArgsModel.y1, overshootArgsModel.x2, overshootArgsModel.y2, overshootArgsModel.x3, overshootArgsModel.y3, overshootArgsModel.x4, overshootArgsModel.y4);
    } else if (curveType == GMCCurveTypeAccelerate) {
        GMCAccelerateArgsModel *accelerateArgsModel = (GMCAccelerateArgsModel *) argsModel;
        value = gmc_accelerate_curve(step, accelerateArgsModel.x1, accelerateArgsModel.y1, accelerateArgsModel.x2, accelerateArgsModel.y2);
    } else if (curveType == GMCCurveTypeDecelerate) {
        GMCDecelerateArgsModel *decelerateArgsModel = (GMCDecelerateArgsModel *) argsModel;
        value = gmc_decelerate_curve(step, decelerateArgsModel.x1, decelerateArgsModel.y1, decelerateArgsModel.x2, decelerateArgsModel.y2);
    } else if (curveType == GMCCurveTypeBounce) {
        GMCBounceArgsModel *bounceArgsModel = (GMCBounceArgsModel *) argsModel;
        value = gmc_bounce_curve(step, bounceArgsModel.v, bounceArgsModel.d);
    } else if (curveType == GMCCurveTypeCosine) {
        GMCCosineArgsModel *cosineArgsModel = (GMCCosineArgsModel *) argsModel;
        value = gmc_cosine_curve(step, cosineArgsModel.d, cosineArgsModel.c);
    } else if (curveType == GMCCurveTypeAnticipate) {
        GMCAnticipateArgsModel *anticipateArgsModel = (GMCAnticipateArgsModel *) argsModel;
        value = gmc_anticipate_curve(step, anticipateArgsModel.d, anticipateArgsModel.x1, anticipateArgsModel.y1, anticipateArgsModel.x2, anticipateArgsModel.y2, anticipateArgsModel.x3, anticipateArgsModel.y3, anticipateArgsModel.x4, anticipateArgsModel.y4);
    } else if (curveType == GMCCurveTypeStandard) {
        GMCStandardArgsModel *standardArgsModel = (GMCStandardArgsModel *) argsModel;
        value = gmc_standard_curve(step, standardArgsModel.x1, standardArgsModel.y1, standardArgsModel.x2, standardArgsModel.y2);
    } else if (curveType == GMCCurveTypeSpring) {
        if ([argsModel isKindOfClass:[GMCDefaultSpringArgsModel class]]) {
            GMCDefaultSpringArgsModel *springArgsModel = (GMCDefaultSpringArgsModel *) argsModel;
            value = gmc_spring_motion_curve(step, springArgsModel.mass, springArgsModel.stiffness, springArgsModel.damping, springArgsModel.velocity);
        } else {
            GMCRK4SpringArgsModel *rk4ArgsModel = (GMCRK4SpringArgsModel *) argsModel;
            value = gmc_spring_rk4_motion_curve(step, lastValue, rk4ArgsModel.tension, rk4ArgsModel.friction, lastVelocity);
        }
    } else {
        value = gmc_linear_curve(step);
    }
    return value;
}

@end
