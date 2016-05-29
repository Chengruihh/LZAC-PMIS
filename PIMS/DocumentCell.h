//
//  DocumentCell.h
//  PIMS
//
//  Created by ChengRui on 16/5/27.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *docNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *docSizeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *downloadImgView;

@end
