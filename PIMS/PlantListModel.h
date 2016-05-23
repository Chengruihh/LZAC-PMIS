//
//  PlantListModel.h
//  PIMS
//
//  Created by ChengRui on 16/4/29.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "EquipmentModel.h"
@interface PlantListModel : EquipmentModel
@property (nonatomic, strong) NSString *parentequipmentcode;
@property (nonatomic, strong) NSString *parentequipmentname;
@property (nonatomic, strong) NSString *lvl;
@end
