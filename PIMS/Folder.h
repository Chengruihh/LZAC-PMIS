//
//  Folder.h
//  PIMS
//
//  Created by ChengRui on 16/5/20.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Document.h"
@interface Folder : NSObject
@property (strong, nonatomic) NSString *folderName;
@property (strong, nonatomic) NSMutableArray<Document *> *documentList;

-(instancetype)initWithName:(NSString *)name andDocuments:(NSArray<Document *> *)documents;
@end
