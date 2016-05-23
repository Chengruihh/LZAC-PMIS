//
//  LoginController.m
//  PIMS
//
//  Created by ChengRui on 16/4/21.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.autoLog.transform = CGAffineTransformMakeScale(0.5, 0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
+(void)presentLoginController:(UIViewController *)vc{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
    NSLog(@"%@\n\n%@",vc, ivc);
    ivc.modalPresentationStyle = UIModalPresentationFormSheet;
    [vc presentViewController:ivc animated:NO completion:nil];
    
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
