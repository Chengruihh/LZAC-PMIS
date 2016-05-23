//
//  Document.m
//  PIMS
//
//  Created by ChengRui on 16/5/20.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "Document.h"

@implementation Document
-(instancetype)initWithName:(NSString *)name Url:(NSString *)url andSize:(NSString *)size{
    self = [super init];
    self.docName = name;
    self.docURL = url;
    self.docSize = size;
    return self;
}
@end
