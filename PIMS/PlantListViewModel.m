//
//  PlantListViewModel.m
//  PIMS
//
//  Created by ChengRui on 16/5/3.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "PlantListViewModel.h"
#import "PlantListModel.h"

@implementation PlantListViewModel

-(NSInteger)numberOfChildren{
    NSInteger i = 0;
    for (PlantListModel *plant in self.SheBeiMuLu) {
        if (plant.lvl == 1) {
            i++;
        }
    }
    return i;
}

-(NSArray<PlantListModel *> *)listOfChildrenPlant{
    NSMutableArray<PlantListModel *> *children = [[NSMutableArray alloc]init];
    for (PlantListModel *plant in self.SheBeiMuLu) {
        if (plant.lvl == 1) {
            [children addObject:plant];
        }
    }
    return children;
}

@end
