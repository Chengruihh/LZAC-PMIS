//
//  LoginController.m
//  PIMS
//
//  Created by ChengRui on 16/4/21.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "LoginController.h"
#import "ActivityIndicator.h"
#import "TabBarController.h"
#import "DataManager.h"
#import "RequestManager.h"
#import "Helper.h"
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSucceed) name:@"loginSucceed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginFailed) name:@"loginFailed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestFailed) name:@"loginRequestFailed" object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSDictionary *dict = [[DataManager sharedInstance]localData];
    if ([dict objectForKey:@"loginInfo"] != nil) {
        self.loginAccount.text = [[dict objectForKey:@"loginInfo"] objectForKey:@"username"];
        self.loginPassword.text = [[dict objectForKey:@"loginInfo"] objectForKey:@"password"];
        [self loginBtnTapped:self];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnTapped:(id)sender {
    
    if (self.loginAccount.text == nil || [self.loginAccount.text isEqualToString:@""]) {
        [Helper showTextView:@"Please enter username." withView:self.view];
        return;
    }
    if (self.loginPassword.text == nil || [self.loginPassword.text isEqualToString:@""]) {
        [Helper showTextView:@"Please enter password." withView:self.view];
        return;
    }
    [ActivityIndicator startActivityIndicator:self];
    self.loginBtn.enabled = NO;
    [[RequestManager sharedInstance] loginWithUsername:self.loginAccount.text andPassword:self.loginPassword.text];
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

-(void)loginSucceed{
    if (self.autoLog.isOn) {
        [[DataManager sharedInstance] saveToLocalData: @{@"username":[DataManager sharedInstance].username,@"password":[DataManager sharedInstance].password} withKey:@"loginInfo"];
    }
    [ActivityIndicator stopActivityIndicator:self];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.loginBtn.enabled = YES;
}

-(void)loginFailed{
    [ActivityIndicator stopActivityIndicator:self];
    [Helper showTextView:@"Please check username and password." withView:self.view];
    self.loginBtn.enabled = YES;
}

-(void)requestFailed{
    [ActivityIndicator stopActivityIndicator:self];
    [Helper showTextView:@"Connection failed, please check your network." withView:self.view];
    self.loginBtn.enabled = YES;
}
-(void)hideKeyboard{
    [[DataManager sharedInstance].currentTF resignFirstResponder];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [DataManager sharedInstance].currentTF = textField;
    return YES;
}

@end
