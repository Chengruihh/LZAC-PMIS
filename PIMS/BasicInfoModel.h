//
//  BasicInfoModel.h
//  PIMS
//
//  Created by ChengRui on 16/4/29.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "EquipmentModel.h"
@interface BasicInfoModel : EquipmentModel
@property (nonatomic, strong) NSString *trademark;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *specification;
@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *procurementdate;
@property (nonatomic, strong) NSString *batchnumbe;
@end
