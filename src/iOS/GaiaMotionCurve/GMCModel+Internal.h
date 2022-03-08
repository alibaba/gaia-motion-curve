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


#import "GMCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMCBaseArgsModel : NSObject

@end

@interface GMCStandardArgsModel : GMCBaseArgsModel

@property(nonatomic, assign) CGFloat x1;
@property(nonatomic, assign) CGFloat y1;
@property(nonatomic, assign) CGFloat x2;
@property(nonatomic, assign) CGFloat y2;

@end

@interface GMCAccelerateArgsModel : GMCStandardArgsModel

@end

@interface GMCDecelerateArgsModel : GMCStandardArgsModel

@end

@interface GMCAnticipateArgsModel : GMCBaseArgsModel

@property(nonatomic, assign) CGFloat d;
@property(nonatomic, assign) CGFloat x1;
@property(nonatomic, assign) CGFloat y1;
@property(nonatomic, assign) CGFloat x2;
@property(nonatomic, assign) CGFloat y2;
@property(nonatomic, assign) CGFloat x3;
@property(nonatomic, assign) CGFloat y3;
@property(nonatomic, assign) CGFloat x4;
@property(nonatomic, assign) CGFloat y4;

@end

@interface GMCOvershootArgsModel : GMCAnticipateArgsModel

@end

@interface GMCBounceArgsModel : GMCBaseArgsModel

@property(nonatomic, assign) CGFloat v;
@property(nonatomic, assign) CGFloat d;

@end

@interface GMCDefaultSpringArgsModel : GMCBaseArgsModel

@property(nonatomic, assign) CGFloat mass;
@property(nonatomic, assign) CGFloat stiffness;
@property(nonatomic, assign) CGFloat damping;
@property(nonatomic, assign) CGFloat velocity;

@end

@interface GMCRK4SpringArgsModel : GMCBaseArgsModel

@property(nonatomic, assign) CGFloat tension;
@property(nonatomic, assign) CGFloat friction;
@property(nonatomic, assign) CGFloat velocity;

@end

@interface GMCCosineArgsModel : GMCBaseArgsModel

@property(nonatomic, assign) CGFloat d;
@property(nonatomic, assign) CGFloat c;

@end


@interface GMCModel (Internal)

@property(nonatomic, strong) GMCBaseArgsModel *argsModel;

+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                     curveType:(GMCCurveType)curveType
                     argsModel:(nullable GMCBaseArgsModel *)argsModel
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue;

@end

NS_ASSUME_NONNULL_END
