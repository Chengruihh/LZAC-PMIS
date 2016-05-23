//
//  DetailViewModel.h
//  PIMS
//
//  Created by ChengRui on 16/5/3.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DetailInfoView.h"
#import "PartsModel.h"
@protocol DetailInfoModel
@end
@protocol PartsModel
@end
@interface DetailViewModel : JSONModel
@property (nonatomic, strong) NSArray<DetailInfoModel> *Table1;
@property (nonatomic, strong) NSArray<PartsModel> *Table2;
@end
