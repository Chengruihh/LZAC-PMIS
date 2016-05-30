//
//  DocListView.h
//  PIMS
//
//  Created by ChengRui on 16/5/9.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocListRequestModel.h"
@protocol DocumentDelegate <NSObject>

-(void)loadPDFViewForDocument;

@end
@interface DocListView : UIView
@property (weak, nonatomic) id<DocumentDelegate> delegate;
@end
