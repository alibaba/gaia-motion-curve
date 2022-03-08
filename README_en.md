# Motion Curve 

The Motion Curve SDK consists of a series of dynamic curve functions. In order to solve the problems of high cost of developing dynamic effects and inconsistent effects and design expectations, each dynamic curve function can be applied to any dynamic attribute. Bring a better experience to users by changing the speed and direction in the animation process, currently including linear curve, acceleration curve, deceleration curve, cosine curve, transition curve, expected curve, standard curve (cubic Bezier curve), bounce Curves, elastic curves, etc., currently support iOS and Android;

[YuQue](https://www.yuque.com/youku-gaia/gaia-motion-curve)

Both `iOS` and `Android` are implemented with the same set of motion curve algorithms to ensure the consistency of motion effects at both ends. The upper layer package of iOS uses `Core Animation`, and Android uses `Interpolator`.

## iOS

#### Install

```ruby
pod  'GaiaMotionCurve',     '0.1.0'
```

#### Header

```objc
#import <GaiaMotionCurve/CALayer+GaiaMotionCurve.h>
```

#### Example

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

#### [Full iOS Demo Project](./examples/iOS)


## Android

#### Install

import compiled aar file

> Directory：src/Android/build/outputs

#### Package

```java
import com.gaia.MotionCurve.*;
```

#### Example

```java
TranslateAnimation animation = new TranslateAnimation(0, displaySize.x - maxTextWidth - 2 * margin, 0, 0);
animation.setFillAfter(true);
animation.setDuration(ANIMATION_DURATION);
animation.setInterpolator(new MotionCurveXStandardInterpolator());
view.startAnimation(animation);

```

#### [Full Android Demo Project](./examples/Android)

## Motion Curve Categories

* [Linear](./docs/en-US/linear.md)
* [Accelerate](./docs/en-US/accelerate.md)
* [Decelerate](./docs/en-US/decelerate.md)
* [Standard](./docs/en-US/standard.md)
* [Anticipate](./docs/en-US/anticipate.md)
* [Overshoot](./docs/en-US/overshoot.md)
* [Spring](./docs/en-US/spring.md)
* [Bounce](./docs/en-US/bounce.md)
* [Cosine](./docs/en-US/cosine.md)

# Code of Conduct

Please refer to [Alibaba Open Source Code of Conduct](https://github.com/AlibabaDR/community/blob/master/CODE_OF_CONDUCT.md).


# LICENCE

gaia-motion-curve is licensed under the Apache License, Version 2.0. See LICENSE for the full license text.

