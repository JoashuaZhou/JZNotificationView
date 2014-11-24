//
//  ViewController.m
//  JZNotificationView
//
//  Created by Joshua Zhou on 14/11/20.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "ViewController.h"
#import "JZNotificationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    [button addTarget:self action:@selector(demo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)demo
{
    [JZNotificationView showWarningWithHeadline:@"警告" message:@"你已被天朝锦衣卫通缉！"];
}

@end
