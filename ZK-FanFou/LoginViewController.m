//
//  LoginViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/25.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)login:(UIBarButtonItem *)sender {
    // 判断账户合法性
    //login sucess
    [self performSegueWithIdentifier:@"ShowAccountsSegue" sender:nil];
    //login fail
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
