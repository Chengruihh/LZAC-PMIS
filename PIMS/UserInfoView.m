//
//  UserInfoView.m
//  PIMS
//
//  Created by ChengRui on 16/5/9.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "UserInfoView.h"
#import "LoginController.h"
#import "Helper.h"
#import "DataManager.h"

@implementation UserInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        if (self.subviews.count == 0) {
            UserInfoView *subView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView"
                                                                    owner:self
                                                                  options:nil] objectAtIndex:0];
            self.usernameLabel.text = [DataManager sharedInstance].username;
            [self addSubview:subView];
        }
    }
    return self;
    
}

- (IBAction)logOutTapped:(id)sender {
    [Helper showOkAlertView:[DataManager sharedInstance].tabController withTitle:@"Do you want to logout?" withMsg:nil withOkHandler:^(void){
        [[DataManager sharedInstance]saveToLocalData:nil withKey:@"loginInfo"];
        [LoginController presentLoginController:[DataManager sharedInstance].tabController];
    } withCompletion:nil];
}

@end
