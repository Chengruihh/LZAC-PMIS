//
//  Document.h
//  PIMS
//
//  Created by ChengRui on 16/5/20.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Document : NSObject
@property (strong ,nonatomic) NSString *docName;
@property (strong, nonatomic) NSString *docURL;
@property (strong, nonatomic) NSString *docSize;

-(instancetype)initWithName:(NSString *)name Url:(NSString *)url andSize:(NSString *)size;
@end
