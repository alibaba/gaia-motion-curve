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


#import <stdio.h>
#import <UIKit/UIKit.h>


#ifndef GMCFunctions_h
#define GMCFunctions_h

CGFloat gmc_linear_curve(CGFloat p);

CGFloat gmc_cosine_curve(CGFloat p, CGFloat d, CGFloat c);

CGFloat gmc_decelerate_curve(CGFloat p, CGFloat x1, CGFloat y1, CGFloat x2,
        CGFloat y2);

CGFloat gmc_accelerate_curve(CGFloat p, CGFloat x1, CGFloat y1, CGFloat x2,
        CGFloat y2);

CGFloat gmc_standard_curve(CGFloat p, CGFloat x1, CGFloat y1, CGFloat x2,
        CGFloat y2);

CGFloat gmc_anticipate_curve(CGFloat p, CGFloat d, CGFloat x1, CGFloat y1,
        CGFloat x2, CGFloat y2, CGFloat x3, CGFloat y3,
        CGFloat x4, CGFloat y4);

CGFloat gmc_overshoot_curve(CGFloat p, CGFloat d, CGFloat x1, CGFloat y1,
        CGFloat x2, CGFloat y2, CGFloat x3, CGFloat y3,
        CGFloat x4, CGFloat y4);

CGFloat gmc_bounce_curve(CGFloat p, CGFloat v, CGFloat d);

CGFloat gmc_spring_motion_curve(CGFloat p, CGFloat m, CGFloat s, CGFloat d,
        CGFloat iv);

CGFloat gmc_spring_rk4_motion_curve(CGFloat p, CGFloat *lastValue,
        CGFloat t, CGFloat f,
        CGFloat *v);

#endif /* GMCFunctions_h */
