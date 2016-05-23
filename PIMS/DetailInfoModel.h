//
//  DetailInfoModel.h
//  PIMS
//
//  Created by ChengRui on 16/4/29.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "EquipmentModel.h"
@interface DetailInfoModel : EquipmentModel
@property (nonatomic, strong) NSString *trademark;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *specification;
@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *procurementdate;
@property (nonatomic, strong) NSString *batchnumbe;
@property (nonatomic, strong) NSString *superequipment;
@property (nonatomic, strong) NSString *externaldimension;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *manufacture;
@property (nonatomic, strong) NSString *factorycode;
@property (nonatomic, strong) NSString *produceddate;
@property (nonatomic, strong) NSString *durableyears;
@property (nonatomic, strong) NSString *maintechnicalparameters;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *equipmentstate;
@property (nonatomic, strong) NSString *modificationtime;
@end
