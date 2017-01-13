//
//  Helper.m
//  PIMS
//
//  Created by ChengRui on 16/5/30.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "Helper.h"

@implementation Helper
+ (void)showTextView:(NSString *)text withView:(UIView *)view {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:2];
}

+ (void)showOkAlertView:(nullable UIViewController *)vc
              withTitle:(nullable NSString *)title
                withMsg:(nullable NSString *)msg
          withOkHandler:(void (^ __nullable)(void))okHandler
         withCompletion:(void (^ __nullable)(UIAlertController *alertView))completion{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, nil) message:NSLocalizedString(msg, nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (okHandler) okHandler();
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertView addAction:okAction];
    [alertView addAction:cancelAction];
    [vc presentViewController:alertView animated:YES completion:nil];
    if (completion) completion(alertView);
}

@end
