//
//  DocListViewModel.m
//  PIMS
//
//  Created by ChengRui on 16/5/20.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "DocListViewModel.h"

@implementation DocListViewModel
-(instancetype)initWithFolders:(NSArray<Folder *> *)folders{
    self = [super init];
    self.folderList = folders;
    return self;
}
@end
