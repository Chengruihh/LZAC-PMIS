//
//  LoginController.h
//  PIMS
//
//  Created by ChengRui on 16/4/21.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *autoLog;
@property (weak, nonatomic) IBOutlet UITextField *loginAccount;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;
+(void)presentLoginController:(UIViewController *)vc;
@end
