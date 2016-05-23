//
//  SearchResultModel.h
//  PIMS
//
//  Created by ChengRui on 16/4/29.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EquipmentModel : JSONModel
@property (nonatomic, strong) NSString *equipmentcode;
@property (nonatomic, strong) NSString *equipmentname;
@property (nonatomic, strong) NSString<Optional> *equipmenttype;
@property (nonatomic, strong) NSString<Optional> *placementposition;
@end
