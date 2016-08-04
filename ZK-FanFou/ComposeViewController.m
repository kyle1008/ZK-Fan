//
//  ComposeViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/3.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "ComposeViewController.h"
#import "Service.h"
#ifdef DEBUG
#define NSLog(FORMAT,...) fprintf(stderr,"\n %s:%d   %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);
#else
#define NSLog(...)
#endif

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ComposeViewController
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (IBAction)close:(UIButton *)sender {
//        [self dismissViewControllerAnimated:YES completion:nil];
//}
//- (IBAction)takePhoto:(UIBarButtonItem *)sender {
//    // 创建pickerController
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    // set delegate
//    picker.delegate = self;
//    // present
//    [self presentViewController:picker animated:YES completion:nil];
//}
//#pragma mark - Picker Delegate
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
//    self.pickerImageView.image = info[UIImagePickerControllerOriginalImage];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    // 取消后退出当前controller
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//- (IBAction)postContent:(UIBarButtonItem *)sender {
//    NSData *data = UIImageJPEGRepresentation(_pickerImageView.image, 0.5);
//    [[Service sharedInstance] postData:@"Test photo" imageData:data replayToStatusID:nil repostStatusID:nil sucess:^(NSArray *result) {
//        NSLog(@"%@",result);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error.description);
//    }];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)takePhoto:(id)sender {
    // 创建pickerController
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // set delegate
    picker.delegate = self;
    // present
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)postContent:(id)sender {
    NSData *data = UIImageJPEGRepresentation(_pickerImageView.image, 0.5);
    [[Service sharedInstance] postData:@"QWERTY" imageData:data replayToStatusID:nil repostStatusID:nil sucess:^(NSArray *result) {
        NSLog(@"%@",result);
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

#pragma mark - picker 代理
// 照片选择完成后调用这个方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.pickerImageView.image = info[UIImagePickerControllerOriginalImage];
    // 选中后取消当前controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // 取消后退出当前controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
