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
@end
