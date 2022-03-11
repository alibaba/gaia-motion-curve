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


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "GMCDefines.h"
#import "NSValue+GMCCGFloat.h"
#import "NSValue+GMCUIColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMCModel : NSObject

//default 0
@property(nonatomic, assign) NSInteger repeatCount;

//default NO
@property(nonatomic, assign) BOOL autoReverse;

//animation key path
@property(nonatomic, strong) NSString *keyPath;

//second
@property(nonatomic, assign) CFTimeInterval duration;

//second
@property(nonatomic, assign) CFTimeInterval delay;

//motion curve type
@property(nonatomic, assign) GMCCurveType curveType;

@property(nonatomic, strong) NSValue *fromValue;

@property(nonatomic, strong) NSValue *toValue;


+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                     curveType:(GMCCurveType)curveType
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue;


+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                     curveType:(GMCCurveType)curveType
                    customArgs:(nullable NSDictionary *)customArgs
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue;


+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                   repeatCount:(NSInteger)repeatCount
                   autoReverse:(BOOL)autoReverse
                     curveType:(GMCCurveType)curveType
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue;


+ (GMCModel *)modelWithKeyPath:(NSString *)keyPath
                      duration:(CFTimeInterval)duration
                         delay:(CFTimeInterval)delay
                   repeatCount:(NSInteger)repeatCount
                   autoReverse:(BOOL)autoReverse
                     curveType:(GMCCurveType)curveType
                    customArgs:(nullable NSDictionary *)customArgs
                     fromValue:(NSValue *)fromValue
                       toValue:(NSValue *)toValue;

@end

NS_ASSUME_NONNULL_END
