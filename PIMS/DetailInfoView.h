//
//  DetailInfoView.h
//  PIMS
//
//  Created by ChengRui on 16/5/9.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfoView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *plantTableView;
@property (weak, nonatomic) IBOutlet UITableView *partsTableView;
@end
