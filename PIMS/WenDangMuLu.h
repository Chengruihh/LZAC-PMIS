//
//  DocListModel.h
//  PIMS
//
//  Created by ChengRui on 16/4/29.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WenDangMuLu : JSONModel
@property (nonatomic, strong) NSString *documentname;
@property (nonatomic, strong) NSString *documenturl;
@property (nonatomic, strong) NSString *documentfolder;
@property (nonatomic, strong) NSString *documentsize;
@end
