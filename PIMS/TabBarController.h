//
//  TabBarController.h
//  PIMS
//
//  Created by ChengRui on 16/4/21.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarController : UIViewController
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
@property (weak, nonatomic) IBOutlet UITabBarItem *detailTab;
@property (weak, nonatomic) IBOutlet UITabBarItem *plantListTab;
@property (weak, nonatomic) IBOutlet UITabBarItem *docListTab;
@property (weak, nonatomic) IBOutlet UITabBarItem *myTab;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@end
