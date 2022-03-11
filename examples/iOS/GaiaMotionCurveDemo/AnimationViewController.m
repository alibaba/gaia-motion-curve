// Copyright 2022 Alibaba Group Holding Ltd.
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

#import "AnimationViewController.h"
#import <GaiaMotionCurve/CALayer+GaiaMotionCurve.h>

@interface AnimationViewController ()

@property(nonatomic, strong) UIView *animationView;
@property(nonatomic, strong) UIView *propertyView;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.

    _animationView = [[UIView alloc] initWithFrame:CGRectMake(80, 200, 40, 40)];
    [_animationView setBackgroundColor:[UIColor blueColor]];
    _animationView.layer.cornerRadius = 5;
    [self.view addSubview:_animationView];
    
    _propertyView = [[UIView alloc] initWithFrame:CGRectMake(20, _animationView.frame.origin.y+_animationView.frame.size.height+50, self.view.bounds.size.width - 40, 200)];
    UIButton *positionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [positionButton addTarget:self action:@selector(posistionAction) forControlEvents:UIControlEventTouchUpInside];
    [positionButton setFrame:CGRectMake(0, 0, (_propertyView.frame.size.width-20)/2, 20)];
    [positionButton setTitle:@"Position" forState:UIControlStateNormal];
    [_propertyView addSubview:positionButton];
    
    UIButton *opacityButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [opacityButton setFrame:CGRectMake(_propertyView.frame.size.width-(_propertyView.frame.size.width-20)/2, 0, (_propertyView.frame.size.width-20)/2, 20)];
    [opacityButton addTarget:self action:@selector(opacityAction) forControlEvents:UIControlEventTouchUpInside];
    [opacityButton setTitle:@"Opacity" forState:UIControlStateNormal];
    [_propertyView addSubview:opacityButton];
    
    UIButton *colorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [colorButton addTarget:self action:@selector(colorAction) forControlEvents:UIControlEventTouchUpInside];
    [colorButton setFrame:CGRectMake(0, 20+20, (_propertyView.frame.size.width-20)/2, 20)];
    [colorButton setTitle:@"Color" forState:UIControlStateNormal];
    [_propertyView addSubview:colorButton];
    
    UIButton *scaleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scaleButton addTarget:self action:@selector(scaleAction) forControlEvents:UIControlEventTouchUpInside];
    [scaleButton setFrame:CGRectMake(_propertyView.frame.size.width-(_propertyView.frame.size.width-20)/2, 20+20, (_propertyView.frame.size.width-20)/2, 20)];
    [scaleButton setTitle:@"Scale" forState:UIControlStateNormal];
    [_propertyView addSubview:scaleButton];
    
    UIButton *rotationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rotationButton addTarget:self action:@selector(rotationAction) forControlEvents:UIControlEventTouchUpInside];
    [rotationButton setFrame:CGRectMake(0, 2*20+2*20, (_propertyView.frame.size.width-20)/2, 20)];
    [rotationButton setTitle:@"Rotation" forState:UIControlStateNormal];
    [_propertyView addSubview:rotationButton];
    
    UIButton *combinationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [combinationButton addTarget:self action:@selector(combinationAction) forControlEvents:UIControlEventTouchUpInside];
    [combinationButton setFrame:CGRectMake(_propertyView.frame.size.width-(_propertyView.frame.size.width-20)/2, 2*20+2*20, (_propertyView.frame.size.width-20)/2, 20)];
    [combinationButton setTitle:@"Combination" forState:UIControlStateNormal];
    [_propertyView addSubview:combinationButton];
    
    UIButton *sequentialButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sequentialButton addTarget:self action:@selector(sequentialAction) forControlEvents:UIControlEventTouchUpInside];
    [sequentialButton setFrame:CGRectMake(0, 2*20+2*20+2*20, (_propertyView.frame.size.width-20)/2, 20)];
    [sequentialButton setTitle:@"Sequential" forState:UIControlStateNormal];
    [_propertyView addSubview:sequentialButton];
    
    [self.view addSubview:_propertyView];
}



- (void)posistionAction {
    CGFloat right = [[UIScreen mainScreen] bounds].size.width - 80 - 20;
    GMCModel *model = [GMCModel modelWithKeyPath:@"position.x"
                                        duration:0.75
                                           delay:0
                                     repeatCount:1
                                     autoReverse:NO
                                       curveType:_curveType
                                       fromValue:[NSValue gmc_valueWithCGFloat:_animationView.center.x]
                                          toValue:[NSValue gmc_valueWithCGFloat:right]];
    __weak typeof(self) weakSelf = self;
    [_animationView.layer gmc_serialAnimationWithGMCModels:@[model] completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.animationView.frame = CGRectMake(80, 200, 40, 40);
        });
    }];

}

- (void)opacityAction {
    GMCModel *model = [GMCModel modelWithKeyPath:@"opacity"
                                        duration:0.75
                                           delay:0
                                       curveType:_curveType
                                       fromValue:[NSValue gmc_valueWithCGFloat:1.0]
                                         toValue:[NSValue gmc_valueWithCGFloat:0]];
    __weak typeof(self) weakSelf = self;
    [_animationView.layer gmc_animateWithGMCModels:@[model] completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.animationView.layer.opacity = 1;
        });
    }];
}

- (void)colorAction {
    GMCModel *model = [GMCModel modelWithKeyPath:@"backgroundColor"
                                        duration:0.75
                                           delay:0
                                       curveType:_curveType
                                       fromValue:[NSValue gmc_valueWithCGColor:[UIColor blueColor].CGColor]
                                         toValue:[NSValue gmc_valueWithCGColor:[UIColor redColor].CGColor]];
    __weak typeof(self) weakSelf = self;
    [_animationView.layer gmc_animateWithGMCModels:@[model] completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.animationView.backgroundColor = [UIColor blueColor];
        });
    }];
}

- (void)scaleAction {
    GMCModel *model = [GMCModel modelWithKeyPath:@"transform.scale"
                                        duration:0.75
                                           delay:0
                                       curveType:_curveType
                                       fromValue:[NSValue gmc_valueWithCGFloat:1.0]
                                         toValue:[NSValue gmc_valueWithCGFloat:2.0]];
    __weak typeof(self) weakSelf = self;
    [_animationView.layer gmc_animateWithGMCModels:@[model] completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.animationView.transform = CGAffineTransformMakeScale(1.f, 1.f);
        });
    }];
}

- (void)rotationAction {
    GMCModel *model = [GMCModel modelWithKeyPath:@"transform.rotation"
                                        duration:0.75
                                           delay:0
                                       curveType:_curveType
                                       fromValue:[NSValue gmc_valueWithCGFloat:0]
                                         toValue:[NSValue gmc_valueWithCGFloat:M_PI * 2]];
    __weak typeof(self) weakSelf = self;
    [_animationView.layer gmc_animateWithGMCModels:@[model] completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.animationView.transform = CGAffineTransformMakeScale(1.f, 1.f);
        });
    }];
}

- (void)combinationAction {
    GMCModel *model1 = [GMCModel modelWithKeyPath:@"backgroundColor"
                                        duration:0.75
                                           delay:0
                                       curveType:_curveType
                                       fromValue:[NSValue gmc_valueWithCGColor:[UIColor blueColor].CGColor]
                                         toValue:[NSValue gmc_valueWithCGColor:[UIColor redColor].CGColor]];
    
    GMCModel *model2 = [GMCModel modelWithKeyPath:@"transform.rotation"
                                        duration:0.75
                                           delay:0
                                       curveType:_curveType
                                       fromValue:[NSValue gmc_valueWithCGFloat:0]
                                         toValue:[NSValue gmc_valueWithCGFloat:M_PI * 2]];
    __weak typeof(self) weakSelf = self;
    [_animationView.layer gmc_animateWithGMCModels:@[model1, model2] completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.animationView.backgroundColor = [UIColor blueColor];
            weakSelf.animationView.transform = CGAffineTransformMakeScale(1.f, 1.f);
        });
    }];
}

- (void)sequentialAction {
    GMCModel *model1 = [GMCModel modelWithKeyPath:@"backgroundColor"
                                        duration:0.75
                                           delay:0
                                       curveType:_curveType
                                       fromValue:[NSValue gmc_valueWithCGColor:[UIColor blueColor].CGColor]
                                         toValue:[NSValue gmc_valueWithCGColor:[UIColor redColor].CGColor]];
    
    GMCModel *model2 = [GMCModel modelWithKeyPath:@"transform.rotation"
                                        duration:0.75
                                           delay:0
                                       curveType:_curveType
                                       fromValue:[NSValue gmc_valueWithCGFloat:0]
                                         toValue:[NSValue gmc_valueWithCGFloat:M_PI * 2]];
    __weak typeof(self) weakSelf = self;
    [_animationView.layer gmc_serialAnimationWithGMCModels:@[model1, model2] completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.animationView.backgroundColor = [UIColor blueColor];
            weakSelf.animationView.transform = CGAffineTransformMakeScale(1.f, 1.f);
        });
    }];
}

@end
