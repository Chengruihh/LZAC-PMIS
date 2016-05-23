//
//  SearchViewModel.h
//  PIMS
//
//  Created by ChengRui on 16/5/3.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol EquipmentModel
@end
@interface SearchViewModel : JSONModel
@property (nonatomic, strong) NSArray<EquipmentModel> *SouSuoJieGuo;
@end
