//
//  RequestManager.m
//  PIMS
//
//  Created by ChengRui on 16/5/12.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "RequestManager.h"
#import "DocListRequestModel.h"
#import <AFHTTPSessionManager.h>

@implementation RequestManager
+ (RequestManager *)sharedInstance {
    static dispatch_once_t pred;
    static RequestManager *requestManager;
    
    dispatch_once(&pred, ^{
        requestManager = [[self alloc] init];
        requestManager.sessionManager = [AFHTTPSessionManager manager];
        [requestManager configSessionManager];
    });
    return requestManager;
}

-(void)configSessionManager{
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
}

-(void)postNotification:(NSString *)name{
    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                            object:nil
                                                          userInfo:nil];
    });
}
-(void)searchWithKeyword:(NSString *)keyword{

    NSDictionary *params = @{@"requestcode":@"002", @"userinput":keyword};
    [_sessionManager POST:PIMS_HOST parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [DataManager sharedInstance].searchViewModel = [[SearchViewModel alloc]initWithString:responseStr error:nil];
        NSLog(@"search result: %@",responseStr);
        [self postNotification:@"searchSucceed"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self postNotification:@"searchFailed"];
        NSLog(@"search fail");
        NSLog(@"%@",error);

    }];
}

-(void)requestBasicInfo:(NSString *)eqptCode{
    NSDictionary *params = @{@"requestcode":@"003", @"equipmentcode":eqptCode};
    [_sessionManager POST:PIMS_HOST parameters:params
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                      [DataManager sharedInstance].basicViewModel = [[BasicViewModel alloc]initWithString:responseStr error:nil];
                      NSLog(@"basic info: %@",responseStr);
                      [self postNotification:@"requestBasicSucceed"];
                  }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      [self postNotification:@"requestBasicFailed"];
                      NSLog(@"basic fail");
                      NSLog(@"%@",error);
    
                  }];
}

-(void)requestDetailInfo:(NSString *)eqptCode{
    NSDictionary *params = @{@"requestcode":@"004", @"equipmentcode":eqptCode};
    [_sessionManager POST:PIMS_HOST parameters:params
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                      [DataManager sharedInstance].detailViewModel = [[DetailViewModel alloc]initWithString:responseStr error:nil];
                      NSLog(@"detail info: %@",responseStr);
                      [self postNotification:@"requestDetailSucceed"];
                  }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      [self postNotification:@"requestDetailFailed"];
                      NSLog(@"detail fail");
                      NSLog(@"%@",error);
                      
                  }];

}

-(void)requestPlantList:(NSString *)eqptCode{
    NSDictionary *params = @{@"requestcode":@"005", @"equipmentcode":eqptCode};
    [_sessionManager POST:PIMS_HOST parameters:params
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                      [DataManager sharedInstance].plantListViewModel = [[PlantListViewModel alloc]initWithString:responseStr error:nil];

                      NSLog(@"plant list: %@",responseStr);
                      [self postNotification:@"requestPlantListSucceed"];
                  }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      [self postNotification:@"requestPlantListFailed"];
                      NSLog(@"plant list fail");
                      NSLog(@"%@",error);
                      
                  }];

}

-(void)requestDocList:(NSString *)eqptCode{
    NSDictionary *params = @{@"requestcode":@"006", @"equipmentcode":eqptCode};
    [_sessionManager POST:PIMS_HOST parameters:params
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                      DocListRequestModel *docListRequestModel = [[DocListRequestModel alloc]initWithString:responseStr error:nil];
                      [DataManager sharedInstance].docListViewModel = [[DataManager sharedInstance]convertDocListViewModel:docListRequestModel];
                      NSLog(@"doc list: %@",responseStr);
                      [self postNotification:@"requestDocListSucceed"];
                  }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      [self postNotification:@"requestDocListFailed"];
                      NSLog(@"doc list fail");
                      NSLog(@"%@",error);
                      
                  }];

}

-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password{}
@end
