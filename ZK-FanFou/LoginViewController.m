//
//  LoginViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/25.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "LoginViewController.h"
#import "Service.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)login:(UIBarButtonItem *)sender {
    // 判断账户合法性
    //login sucess
    
    [[Service sharedInstance] authoriseWithUserName:@"zank9@qq.com" password:@"ZKff1008" success:^(NSString *token, NSString *tokenSecret) {
        [[Service sharedInstance] requestVerifyCredential:nil accessToken:token tokenSecret:tokenSecret requestMethod:@"GET" sucess:^(NSDictionary *result) {
            
            [self performSegueWithIdentifier:@"ShowAccountsSegue" sender:nil];
        }];
    }];
    //success:^(NSString *token, NSString *tokenSecret) {   }
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

@end
