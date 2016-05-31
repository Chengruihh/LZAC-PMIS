//
//  LoginController.m
//  PIMS
//
//  Created by ChengRui on 16/4/21.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "LoginController.h"
#import "TabBarController.h"
#import "DataManager.h"
@interface LoginController () <UITextFieldDelegate>

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.autoLog.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.loginAccount.delegate = self;
    self.loginPassword.delegate = self;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
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
-(void)hideKeyboard{
    [[DataManager sharedInstance].currentTF resignFirstResponder];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [DataManager sharedInstance].currentTF = textField;
    return YES;
}

@end
