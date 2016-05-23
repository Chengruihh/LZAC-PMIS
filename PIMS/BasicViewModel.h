//
//  BasicViewModel.h
//  PIMS
//
//  Created by ChengRui on 16/5/3.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol BasicInfoModel
@end
@interface BasicViewModel : JSONModel
@property (nonatomic, strong) NSArray<BasicInfoModel> *JiBenXinXi;
@end
