//
//  Folder.m
//  PIMS
//
//  Created by ChengRui on 16/5/20.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "Folder.h"

@implementation Folder
-(instancetype)initWithName:(NSString *)name andDocuments:(NSArray<Document *> *)documents{
    self = [super init];
    self.folderName = name;
    self.documentList = [[NSMutableArray alloc]initWithArray: documents];
    return self;
}
@end
