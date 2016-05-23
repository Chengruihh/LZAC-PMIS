//
//  DocListViewModel.h
//  PIMS
//
//  Created by ChengRui on 16/5/20.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Folder.h"
@interface DocListViewModel : NSObject
@property (strong, nonatomic) NSArray<Folder *> *folderList;

-(instancetype)initWithFolders:(NSArray<Folder *> *)folders;
@end
