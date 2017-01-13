//
//  DataManager.h
//  PIMS
//
//  Created by ChengRui on 16/5/11.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabBarController.h"
#import "BasicViewModel.h"
#import "DetailViewModel.h"
#import "PlantListViewModel.h"
#import "DocListRequestModel.h"
#import "SearchViewModel.h"
#import "DocListViewModel.h"

@interface DataManager : NSObject
+ (DataManager *)sharedInstance;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (weak, nonatomic) TabBarController *tabController;
@property (strong, nonatomic) BasicViewModel *basicViewModel;
@property (strong, nonatomic) DetailViewModel *detailViewModel;
@property (strong, nonatomic) PlantListViewModel *plantListViewModel;
@property (strong, nonatomic) SearchViewModel *searchViewModel;
@property (strong, nonatomic) DocListViewModel *docListViewModel;
@property (assign, nonatomic) CGRect midViewFrame;
@property (strong, nonatomic) NSString *selectedDocUrl;
@property (weak, nonatomic) UITextField *currentTF;

-(DocListViewModel *)convertDocListViewModel:(DocListRequestModel *)docListRequestModel;
- (BOOL)saveToLocalData:(NSObject *)savedObject withKey:(NSString *)key;
- (NSDictionary *)localData;

#define themeBlue 0x0F3464
@end
