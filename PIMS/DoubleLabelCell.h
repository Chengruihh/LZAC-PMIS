//
//  DoubleLabelCellTableViewCell.h
//  PIMS
//
//  Created by ChengRui on 16/5/11.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoubleLabelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@end
