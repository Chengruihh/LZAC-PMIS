//
//  DataManager.m
//  PIMS
//
//  Created by ChengRui on 16/5/11.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "DataManager.h"
#import "Document.h"
#import "Folder.h"
#import "WenDangMuLu.h"

@implementation DataManager
+ (DataManager *)sharedInstance {
    static dispatch_once_t pred;
    static DataManager *dataManager;
    
    dispatch_once(&pred, ^{
        dataManager = [[self alloc] init];
    });
    return dataManager;
}

- (DocListViewModel *)convertDocListViewModel:(DocListRequestModel *)docListRequestModel{
    NSMutableArray<Folder *> *folderList = [[NSMutableArray<Folder *> alloc]init];
    for (WenDangMuLu *wdml in docListRequestModel.WenDangMuLu) {
        bool contain = NO;
        for (Folder *folder in folderList) {
            if ([folder.folderName isEqualToString:wdml.documentfolder]) {
                contain = YES;
                [folder.documentList addObject:[[Document alloc]initWithName:wdml.documentname Url:wdml.documenturl andSize:wdml.documentsize]];
                break;
            }
        }
        if (!contain) {
            NSArray<Document *> *temp = @[[[Document alloc]initWithName:wdml.documentname Url:wdml.documenturl andSize:wdml.documentsize]];
            [folderList addObject:[[Folder alloc]initWithName:wdml.documentfolder andDocuments:temp]];
        }
    }
    return [[DocListViewModel alloc]initWithFolders:folderList];
}

- (BOOL)saveToLocalData:(NSObject *)savedObject withKey:(NSString *)key {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:[self fileName]];
    if (data == nil) {
        data = [[NSMutableDictionary alloc] init];
    }
    [data setValue:savedObject forKey:key];
    return [self writeFileWithData:data];
}

- (BOOL)writeFileWithData: (NSMutableDictionary *) data {
    if (data == nil) {
        data = [[NSMutableDictionary alloc] init];
    }
    return [data writeToFile: [self fileName] atomically:YES];
}

- (NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* plistPath = [paths objectAtIndex:0];
    NSString *filename =[plistPath stringByAppendingPathComponent:@"PIMSData.plist"];
    return filename;
}

- (NSDictionary *)localData {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:[self fileName]];
    if (data == nil) {
        data = [[NSMutableDictionary alloc] init];
    }
    return data;
}

@end
