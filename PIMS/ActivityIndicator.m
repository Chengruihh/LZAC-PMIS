//
//  ActivityIndicator.m
//  PIMS
//
//  Created by ChengRui on 16/5/30.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "ActivityIndicator.h"
#import "DataManager.h"

@implementation ActivityIndicator
static UIActivityIndicatorView *activity;

+ (void)startActivityIndicator:(UIViewController *)vc{
    if (![activity isAnimating]) {
        activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [activity setCenter:CGPointMake(vc.view.frame.size.width/2, vc.view.frame.size.height/2)];
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activity.color = UIColorFromRGB(themeBlue);
        [vc.view addSubview:activity];
        [activity startAnimating];
    }
}
+ (void)stopActivityIndicator:(UIViewController *)vc{
    if ([activity isAnimating]) {
        [activity stopAnimating];
    }
}
@end
