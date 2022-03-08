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

#import <QuartzCore/QuartzCore.h>
#import "GMCModel.h"
#import "NSValue+GMCCGFloat.h"
#import "NSValue+GMCUIColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (GaiaMotionCurve) <CAAnimationDelegate>

/**
 when finished，will auto set toValue to layer，do not need set in completion block again
 @param models animation models array
 @param completion finished block
 @return animation unique id
 */
- (NSString *)gmc_animateWithGMCModels:(NSArray<GMCModel *> *)models
                            completion:(GMCCompletionBlock)completion;


//serial animation
- (NSString *)gmc_serialAnimationWithGMCModels:(NSArray<GMCModel *> *)models
                                    completion:(GMCCompletionBlock)completion;

/**
 cancel animation with animationID
 @param animationID animation unique id
 */
- (void)gmc_cancelAnimationWithID:(NSString *)animationID;

// cancel all animations
- (void)gmc_cancelAllAnimations;


@property(nonatomic, strong) NSMutableDictionary *gmc_animationKeys;


@end

NS_ASSUME_NONNULL_END
