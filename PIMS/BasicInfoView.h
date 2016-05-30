//
//  BasicInfoView.h
//  PIMS
//
//  Created by ChengRui on 16/5/9.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewModel.h"
#import "BasicInfoModel.h"

@protocol SearchDelegate <NSObject>

-(void)showActivityIndicator;

@end
@interface BasicInfoView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) id<SearchDelegate> delegate;
@property (strong, nonatomic) BasicInfoModel *basicInfoModel;
@property (assign, nonatomic) bool isSearch;
@property (weak, nonatomic) IBOutlet UITableView *basicInfoTableView;

@end
