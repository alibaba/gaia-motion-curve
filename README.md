# 动效曲线

> [en-US](./README_en.md)

动效曲线SDK 由一系列的动效曲线函数构成，为了解决开发动效的成本高、效果和设计的预期不一致的问题，每个动效曲线函数可应用于任意一个可动效的属性上，通过改变动效过程中的速率和方向给用户带来更好的体验，目前包括线性曲线、加速曲线、减速曲线、余弦曲线、过度曲线、预期曲线、标准曲线（三次贝塞尔曲线）、弹跳曲线、弹性曲线等，目前支持 iOS 和 Android；

[语雀知识库地址](https://www.yuque.com/youku-gaia/gaia-motion-curve)

`iOS`和`Android`均用同一套动效曲线的算法实现，保证双端的动效的一致性，iOS 上层封装使用的是`Core Animation`，Android 则是使用的`插值器`。

## iOS

#### 安装

```ruby
pod  'GaiaMotionCurve',     '0.1.0'
```

#### 头文件

```objc
#import <GaiaMotionCurve/CALayer+GaiaMotionCurve.h>
```

#### 例子

```objc

#import <GaiaMotionCurve/CALayer+GaiaMotionCurve.h>

NSMutableArray *animationModels = [[NSMutableArray alloc] init];
GMCModel *model1 =[GMCModel modelWithKeyPath:@"opacity"
                                    duration:0.2
                                       delay:0
                                   curveType:MCXCurveTypeStandard
                                   fromValue:[NSValue gmc_valueWithCGFloat:0]
                                     toValue:[NSValue gmc_valueWithCGFloat:0.9]];
[animationModels addObject:model1];
[_tipsImageView.layer gmc_animateWithAnimationModels:animationModels completion:^(BOOL finished) {}];

```

#### [完整iOS Demo 工程](./examples/iOS)


## Android

#### 安装

引入编译的aar文件

> 目录：src/Android/build/outputs

#### 包名

```java

import com.gaia.MotionCurve.*;

```

#### 例子

```java

TranslateAnimation animation = new TranslateAnimation(0, displaySize.x - maxTextWidth - 2 * margin, 0, 0);
animation.setFillAfter(true);
animation.setDuration(ANIMATION_DURATION);
animation.setInterpolator(new MotionCurveXStandardInterpolator());
view.startAnimation(animation);

```

#### [完整Android Demo 工程](./examples/Android)

## 曲线分类

* [线性曲线](./docs/zh-CN/linear.md)
* [加速曲线](./docs/zh-CN/accelerate.md)
* [减速曲线](./docs/zh-CN/decelerate.md)
* [标准曲线](./docs/zh-CN/standard.md)
* [预期曲线](./docs/zh-CN/anticipate.md)
* [过度曲线](./docs/zh-CN/overshoot.md)
* [弹性曲线](./docs/zh-CN/spring.md)
* [弹跳曲线](./docs/zh-CN/bounce.md)
* [余弦曲线](./docs/zh-CN/cosine.md)

# 行为准则

请参考[Alibaba Open Source Code of Conduct](https://github.com/AlibabaDR/community/blob/master/CODE_OF_CONDUCT.md) ([中文版](https://github.com/AlibabaDR/community/blob/master/CODE_OF_CONDUCT_zh.md)).


# 开源协议

gaia-motion-curve is licensed under the Apache License, Version 2.0. See LICENSE for the full license text.

