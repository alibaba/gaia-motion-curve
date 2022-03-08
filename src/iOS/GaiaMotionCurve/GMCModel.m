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
#import "GMCModel+Internal.h"

@implementation GMCModel

+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                     curveType:(GMCCurveType)curveType
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue {
    return [GMCModel modelWithKeyPath:keyPath
                             duration:duration
                                delay:delay
                            curveType:curveType
                           customArgs:nil
                            fromValue:fromValue
                              toValue:toValue];
}

+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                     curveType:(GMCCurveType)curveType
                    customArgs:(nullable NSDictionary *)customArgs
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue {
    return [GMCModel modelWithKeyPath:keyPath
                             duration:duration
                                delay:delay
                          repeatCount:0
                          autoReverse:NO
                            curveType:curveType
                           customArgs:customArgs
                            fromValue:fromValue
                              toValue:toValue];

}


+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                   repeatCount:(NSInteger)repeatCount
                   autoReverse:(BOOL)autoReverse
                     curveType:(GMCCurveType)curveType
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue {
    return [GMCModel modelWithKeyPath:keyPath
                             duration:duration
                                delay:delay
                          repeatCount:repeatCount
                          autoReverse:autoReverse
                            curveType:curveType
                           customArgs:nil
                            fromValue:fromValue
                              toValue:toValue];
}


+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                   repeatCount:(NSInteger)repeatCount
                   autoReverse:(BOOL)autoReverse
                     curveType:(GMCCurveType)curveType
                    customArgs:(nullable NSDictionary *)customArgs
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue {
    GMCModel *model = [[GMCModel alloc] init];
    model.keyPath = keyPath;
    model.duration = duration;
    model.delay = delay;
    model.repeatCount = repeatCount;
    model.autoReverse = autoReverse;
    model.curveType = curveType;
    model.fromValue = fromValue;
    model.toValue = toValue;
    if (curveType == GMCCurveTypeCosine) {
        GMCCosineArgsModel *argsModel = [[GMCCosineArgsModel alloc] init];
        argsModel.d = customArgs[@"d"] != nil ? [customArgs[@"d"] floatValue] : 1.0f;
        argsModel.c = customArgs[@"c"] != nil ? [customArgs[@"c"] floatValue] : 1.0f;
        model.argsModel = argsModel;
    } else if (curveType == GMCCurveTypeBounce) {
        GMCBounceArgsModel *argsModel = [[GMCBounceArgsModel alloc] init];
        argsModel.v = customArgs[@"v"] != nil ? [customArgs[@"v"] floatValue] : 1.0f;
        argsModel.d = customArgs[@"d"] != nil ? [customArgs[@"d"] floatValue] : 1.0f;
        model.argsModel = argsModel;
    } else if (curveType == GMCCurveTypeAccelerate) {
        GMCAccelerateArgsModel *argsModel = [[GMCAccelerateArgsModel alloc] init];
        argsModel.x1 = customArgs[@"x1"] != nil ? [customArgs[@"x1"] floatValue] : 0.4f;
        argsModel.y1 = customArgs[@"y1"] != nil ? [customArgs[@"y1"] floatValue] : 0.0f;
        argsModel.x2 = customArgs[@"x2"] != nil ? [customArgs[@"x2"] floatValue] : 1.0f;
        argsModel.y2 = customArgs[@"y2"] != nil ? [customArgs[@"y2"] floatValue] : 1.0f;
        model.argsModel = argsModel;
    } else if (curveType == GMCCurveTypeDecelerate) {
        GMCDecelerateArgsModel *argsModel = [[GMCDecelerateArgsModel alloc] init];
        argsModel.x1 = customArgs[@"x1"] != nil ? [customArgs[@"x1"] floatValue] : 0.0f;
        argsModel.y1 = customArgs[@"y1"] != nil ? [customArgs[@"y1"] floatValue] : 0.0f;
        argsModel.x2 = customArgs[@"x2"] != nil ? [customArgs[@"x2"] floatValue] : 0.1f;
        argsModel.y2 = customArgs[@"y2"] != nil ? [customArgs[@"y2"] floatValue] : 1.0f;
        model.argsModel = argsModel;
    } else if (curveType == GMCCurveTypeStandard) {
        GMCStandardArgsModel *argsModel = [[GMCStandardArgsModel alloc] init];
        argsModel.x1 = customArgs[@"x1"] != nil ? [customArgs[@"x1"] floatValue] : 0.4f;
        argsModel.y1 = customArgs[@"y1"] != nil ? [customArgs[@"y1"] floatValue] : 0.0f;
        argsModel.x2 = customArgs[@"x2"] != nil ? [customArgs[@"x2"] floatValue] : 0.1f;
        argsModel.y2 = customArgs[@"y2"] != nil ? [customArgs[@"y2"] floatValue] : 1.0f;
        model.argsModel = argsModel;
    } else if (curveType == GMCCurveTypeOvershoot) {
        GMCOvershootArgsModel *argsModel = [[GMCOvershootArgsModel alloc] init];
        argsModel.d = customArgs[@"d"] != nil ? [customArgs[@"d"] floatValue] : 1.2f;
        argsModel.x1 = customArgs[@"x1"] != nil ? [customArgs[@"x1"] floatValue] : 0.33f;
        argsModel.y1 = customArgs[@"y1"] != nil ? [customArgs[@"y1"] floatValue] : 0.0f;
        argsModel.x2 = customArgs[@"x2"] != nil ? [customArgs[@"x2"] floatValue] : 0.3f;
        argsModel.y2 = customArgs[@"y2"] != nil ? [customArgs[@"y2"] floatValue] : 1.0f;
        argsModel.x3 = customArgs[@"x3"] != nil ? [customArgs[@"x3"] floatValue] : 0.33f;
        argsModel.y3 = customArgs[@"y3"] != nil ? [customArgs[@"y3"] floatValue] : 0.0f;
        argsModel.x4 = customArgs[@"x4"] != nil ? [customArgs[@"x4"] floatValue] : 0.5f;
        argsModel.y4 = customArgs[@"y4"] != nil ? [customArgs[@"y4"] floatValue] : 1.0f;
        model.argsModel = argsModel;
    } else if (curveType == GMCCurveTypeAnticipate) {
        GMCAnticipateArgsModel *argsModel = [[GMCAnticipateArgsModel alloc] init];
        argsModel.d = customArgs[@"d"] != nil ? [customArgs[@"d"] floatValue] : 0.2f;
        argsModel.x1 = customArgs[@"x1"] != nil ? [customArgs[@"x1"] floatValue] : 0.33f;
        argsModel.y1 = customArgs[@"y1"] != nil ? [customArgs[@"y1"] floatValue] : 0.0f;
        argsModel.x2 = customArgs[@"x2"] != nil ? [customArgs[@"x2"] floatValue] : 0.67f;
        argsModel.y2 = customArgs[@"y2"] != nil ? [customArgs[@"y2"] floatValue] : 1.0f;
        argsModel.x3 = customArgs[@"x3"] != nil ? [customArgs[@"x3"] floatValue] : 0.33f;
        argsModel.y3 = customArgs[@"y3"] != nil ? [customArgs[@"y3"] floatValue] : 0.0f;
        argsModel.x4 = customArgs[@"x4"] != nil ? [customArgs[@"x4"] floatValue] : 0.2f;
        argsModel.y4 = customArgs[@"y4"] != nil ? [customArgs[@"y4"] floatValue] : 1.0f;
        model.argsModel = argsModel;
    } else if (curveType == GMCCurveTypeSpring) {
        if (customArgs[@"m"] != nil || customArgs[@"s"] != nil || customArgs[@"d"] != nil || customArgs[@"iv"] != nil) {
            GMCDefaultSpringArgsModel *argsModel = [[GMCDefaultSpringArgsModel alloc] init];
            argsModel.mass = customArgs[@"m"] != nil ? [customArgs[@"m"] floatValue] : 0.7f;
            argsModel.stiffness = customArgs[@"s"] != nil ? [customArgs[@"s"] floatValue] : 380.0f;
            argsModel.damping = customArgs[@"d"] != nil ? [customArgs[@"d"] floatValue] : 10.0f;
            argsModel.velocity = customArgs[@"iv"] != nil ? [customArgs[@"iv"] floatValue] : -2.0f;
            model.argsModel = argsModel;
        } else {
            GMCRK4SpringArgsModel *argsModel = [[GMCRK4SpringArgsModel alloc] init];
            argsModel.tension = customArgs[@"t"] != nil ? [customArgs[@"t"] floatValue] : 533.0f;
            argsModel.friction = customArgs[@"f"] != nil ? [customArgs[@"f"] floatValue] : 14.0f;
            argsModel.velocity = customArgs[@"v"] != nil ? [customArgs[@"v"] floatValue] : -2.0f;
            model.argsModel = argsModel;
        }
    }
    return model;
}


@end
