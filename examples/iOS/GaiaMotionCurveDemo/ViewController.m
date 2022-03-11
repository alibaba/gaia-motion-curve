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

#import "ViewController.h"
#import "AnimationViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) NSArray *curveTypeArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    self.title = @"动效曲线";


    _dataArray = @[@"线性曲线(Linear)", @"加速曲线(Accelerate)", @"减速曲线(Decelerate)", @"标准曲线(Standard)", @"预期曲线(Anticipate)", @"过度曲线(Overshoot)", @"弹性曲线(Spring)", @"弹跳曲线(Bounce)", @"余弦曲线(Cosine)"];
    _curveTypeArray = @[@(GMCCurveTypeLinear), @(GMCCurveTypeAccelerate), @(GMCCurveTypeDecelerate), @(GMCCurveTypeStandard), @(GMCCurveTypeAnticipate), @(GMCCurveTypeOvershoot), @(GMCCurveTypeSpring), @(GMCCurveTypeBounce), @(GMCCurveTypeCosine)];

    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _dataArray[indexPath.section];
    cell.accessoryType = UITableViewRowAnimationRight;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AnimationViewController *controller = [[AnimationViewController alloc] initWithNibName:nil bundle:nil];
    controller.curveType = [_curveTypeArray[indexPath.section] integerValue];
    controller.title = _dataArray[indexPath.section];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
