//
//  PartsModel.h
//  PIMS
//
//  Created by ChengRui on 16/5/3.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PartsModel : JSONModel
@property (nonatomic, strong) NSString *partsname;
@property (nonatomic, strong) NSString *subordinateequipment;
@property (nonatomic, strong) NSString *specification;
@property (nonatomic, strong) NSString *texture;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *modificationtime;
@end
