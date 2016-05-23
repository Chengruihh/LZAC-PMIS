//
//  DataManager.h
//  PIMS
//
//  Created by ChengRui on 16/5/11.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicViewModel.h"
#import "DetailViewModel.h"
#import "PlantListViewModel.h"
#import "DocListRequestModel.h"
#import "SearchViewModel.h"
#import "DocListViewModel.h"

@interface DataManager : NSObject
+ (DataManager *)sharedInstance;
@property (strong, nonatomic) BasicViewModel *basicViewModel;
@property (strong, nonatomic) DetailViewModel *detailViewModel;
@property (strong, nonatomic) PlantListViewModel *plantListViewModel;
//@property (strong, nonatomic) DocListRequestModel *docListRequestModel;
@property (strong, nonatomic) SearchViewModel *searchViewModel;
@property (strong, nonatomic) DocListViewModel *docListViewModel;

-(DocListViewModel *)convertDocListViewModel:(DocListRequestModel *)docListRequestModel;
@end
