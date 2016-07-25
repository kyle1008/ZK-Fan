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
    [super viewDidLoad];
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL isUserExist = NO;
        if (isUserExist) {
            [self performSegueWithIdentifier:@"MainSegue" sender:nil];
        }else{
            [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
        }
    });
                  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
