//
//  BasicInfoView.m
//  PIMS
//
//  Created by ChengRui on 16/5/9.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "BasicInfoView.h"
#import "DoubleLabelCell.h"
#import "FourLabelCell.h"
#import "DataManager.h"
#import "RequestManager.h"

@implementation BasicInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        if (self.subviews.count == 0) {
            BasicInfoView *subView = [[[NSBundle mainBundle] loadNibNamed:@"BasicInfoView"
                                                                       owner:self
                                                                     options:nil] objectAtIndex:0];
            
            [self addSubview:subView];
        }
//        UINib *nib = [UINib nibWithNibName:@"DoubleLabelCell" bundle:nil];
//        [self.basicInfoTableView registerNib:nib forCellReuseIdentifier:@"DoubleLabelCell"];
        if ([DataManager sharedInstance].basicViewModel) {
            self.basicInfoModel = [DataManager sharedInstance].basicViewModel.JiBenXinXi.firstObject;
        }
        self.basicInfoTableView.tableFooterView = [[UIView alloc]init];
    }
    return self;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isSearch) {
        if ([DataManager sharedInstance].searchViewModel.SouSuoJieGuo.count == 0) {
            return 1;
        }
        else
            return [DataManager sharedInstance].searchViewModel.SouSuoJieGuo.count;
    }
    else
        return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
        return 110;
    }
    else
        return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isSearch) {
        FourLabelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"FourLabelCell" owner:self options:nil];
            cell = (FourLabelCell*)[cellObjects objectAtIndex:0];
        }
        if ([DataManager sharedInstance].searchViewModel.SouSuoJieGuo.count == 0) {
            cell.firstLabel.text = @"   No matched result.";
            cell.secondLabel.text = @"";
            cell.thirdLabel.text = @"";
            cell.fourthLabel.text = @"";
        }
        else{
            cell.firstLabel.text = [NSString stringWithFormat:@"Equipment Name: %@",[[DataManager sharedInstance].searchViewModel.SouSuoJieGuo[indexPath.row] equipmentname]];
            cell.secondLabel.text = [NSString stringWithFormat:@"Equipment Code: %@", [[DataManager sharedInstance].searchViewModel.SouSuoJieGuo[indexPath.row] equipmentcode]];
            cell.thirdLabel.text = [NSString stringWithFormat:@"Equipment Category: %@", [[DataManager sharedInstance].searchViewModel.SouSuoJieGuo[indexPath.row] equipmenttype] ];
            cell.fourthLabel.text = [NSString stringWithFormat:@"Location: %@", [[DataManager sharedInstance].searchViewModel.SouSuoJieGuo[indexPath.row] placementposition]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        DoubleLabelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"DoubleLabelCell" owner:self options:nil];
            cell = cellObjects.firstObject;
        }
//        cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
        switch (indexPath.row) {
            case 0:
                cell.imgView.image = [UIImage imageNamed:@"code"];
                cell.firstLabel.text = @"Equipment Code";
                cell.secondLabel.text = self.basicInfoModel.equipmentcode;
                break;
            case 1:
                cell.imgView.image = [UIImage imageNamed:@"name"];
                cell.firstLabel.text = @"Equipment Name";
                cell.secondLabel.text = self.basicInfoModel.equipmentname;
                break;
            case 2:
                cell.imgView.image = [UIImage imageNamed:@"brand"];
                cell.firstLabel.text = @"Brand";
                cell.secondLabel.text = self.basicInfoModel.trademark;
                break;
            case 3:
                cell.imgView.image = [UIImage imageNamed:@"model"];
                cell.firstLabel.text = @"Model";
                cell.secondLabel.text = self.basicInfoModel.type;
                break;
            case 4:
                cell.imgView.image = [UIImage imageNamed:@"specification"];
                cell.firstLabel.text = @"Specification";
                cell.secondLabel.text = self.basicInfoModel.specification;
                break;
            case 5:
                cell.imgView.image = [UIImage imageNamed:@"supplier"];
                cell.firstLabel.text = @"Supplier";
                cell.secondLabel.text = self.basicInfoModel.provider;
                break;
            case 6:
                cell.imgView.image = [UIImage imageNamed:@"purchase_date"];
                cell.firstLabel.text = @"Procurement Data";
                cell.secondLabel.text = self.basicInfoModel.procurementdate;
                break;
            case 7:
                cell.imgView.image = [UIImage imageNamed:@"batch_number"];
                cell.firstLabel.text = @"Batch No.";
                cell.secondLabel.text = self.basicInfoModel.batchnumbe;
                break;
            case 8:
                cell.imgView.image = [UIImage imageNamed:@"location"];
                cell.firstLabel.text = @"Location";
                cell.secondLabel.text = self.basicInfoModel.placementposition;
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
        if([DataManager sharedInstance].searchViewModel.SouSuoJieGuo.count > 0){
            [self.delegate showActivityIndicator];
            [[RequestManager sharedInstance] requestBasicInfo:[[DataManager sharedInstance].searchViewModel.SouSuoJieGuo[indexPath.row] equipmentcode]];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[DataManager sharedInstance].currentTF resignFirstResponder];
}
@end
