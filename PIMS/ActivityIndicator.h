//
//  ActivityIndicator.h
//  PIMS
//
//  Created by ChengRui on 16/5/30.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ActivityIndicator : NSObject
+ (void)startActivityIndicator:(UIViewController *)vc;
+ (void)stopActivityIndicator:(UIViewController *)vc;
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@end
