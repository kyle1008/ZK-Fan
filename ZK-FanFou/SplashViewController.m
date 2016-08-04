//
//  SplashViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/25.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    NSLog(@"%s", __func__);
    [super viewDidLoad];
    //不阻塞当前主线程执行
    NSLog(@"1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"3");
        BOOL isUserExist = NO;
        if (isUserExist) {
            [self performSegueWithIdentifier:@"MainSegue" sender:nil];
        }else{
            [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
        }
    });
    NSLog(@"2");
}

@end
