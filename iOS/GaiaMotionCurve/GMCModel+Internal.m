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

#import "GMCModel+Internal.h"
#import <objc/runtime.h>

@implementation GMCBaseArgsModel
@end

@implementation GMCStandardArgsModel
@end

@implementation GMCAccelerateArgsModel
@end

@implementation GMCDecelerateArgsModel
@end

@implementation GMCAnticipateArgsModel
@end

@implementation GMCOvershootArgsModel
@end

@implementation GMCBounceArgsModel
@end

@implementation GMCDefaultSpringArgsModel
@end

@implementation GMCRK4SpringArgsModel
@end

@implementation GMCCosineArgsModel
@end


@implementation GMCModel (Internal)

static NSString *kGMCModelArgsModelKey = @"kGMCModelArgsModelKey";

- (void)setArgsModel:(GMCBaseArgsModel *)argsModel {
    objc_setAssociatedObject(self, &kGMCModelArgsModelKey, argsModel,
            OBJC_ASSOCIATION_RETAIN);
}

- (GMCBaseArgsModel *)argsModel {
    return objc_getAssociatedObject(self, &kGMCModelArgsModelKey);
}

+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                     curveType:(GMCCurveType)curveType
                     argsModel:(nullable GMCBaseArgsModel *)argsModel
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue {
    GMCModel *model = [GMCModel modelWithKeyPath:keyPath
                                        duration:duration
                                           delay:delay
                                       curveType:curveType
                                       fromValue:fromValue
                                         toValue:toValue];
    model.argsModel = argsModel;
    return model;
}

@end
