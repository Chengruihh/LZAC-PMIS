//
//  RequestManager.h
//  PIMS
//
//  Created by ChengRui on 16/5/12.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
#import "DataManager.h"
@interface RequestManager : NSObject
+ (RequestManager *)sharedInstance;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;
-(void)searchWithKeyword:(NSString *)keyword;
-(void)requestDetailInfo:(NSString *)eqptCode;
-(void)requestPlantList:(NSString *)eqptCode;
-(void)requestDocList:(NSString *)eqptCode;
-(void)requestBasicInfo:(NSString *)eqptCode;

#define PIMS_HOST @"http://218.24.232.66:99/Switches"
@end
