//
//  Helper.h
//  PIMS
//
//  Created by ChengRui on 16/5/30.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
@interface Helper : NSObject
+ (void)showTextView:(nonnull NSString *)text withView:(nonnull UIView *)view;
+ (void)showOkAlertView:(nullable UIViewController *)vc
              withTitle:(nullable NSString *)title
                withMsg:(nullable NSString *)msg
          withOkHandler:(void (^ __nullable)(void))okHandler
         withCompletion:(void (^ __nullable)( UIAlertController * _Nullable alertView))completion;

@end
