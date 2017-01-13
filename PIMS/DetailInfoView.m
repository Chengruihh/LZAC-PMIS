//
//  DetailInfoView.m
//  PIMS
//
//  Created by ChengRui on 16/5/9.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "DetailInfoView.h"
#import "DoubleLabelCell.h"
#import "SixLabelCell.h"
#import "DataManager.h"
#import "DetailInfoModel.h"
#import "PartsModel.h"
@implementation DetailInfoView

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
            DetailInfoView *subView = [[[NSBundle mainBundle] loadNibNamed:@"DetailInfoView"
                                                                    owner:self
                                                                  options:nil] objectAtIndex:0];
            
            [self addSubview:subView];
        }
        //        UINib *nib = [UINib nibWithNibName:@"DoubleLabelCell" bundle:nil];
        //        [self.basicInfoTableView registerNib:nib forCellReuseIdentifier:@"DoubleLabelCell"];
        
        self.partsTableView.tableFooterView=[[UIView alloc]init];
        self.plantTableView.tableFooterView=[[UIView alloc]init];
    }
    
    return self;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.plantTableView) {
        return 60;
    }
    else
        return 140;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.plantTableView) {
        return 19;
    }
    else{
//        NSLog(@"%lul",(unsigned long)[DataManager sharedInstance].detailViewModel.Table1.count);
        return [DataManager sharedInstance].detailViewModel.Table2.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.plantTableView) {
        DoubleLabelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"DoubleLabelCell" owner:self options:nil];
            cell = (DoubleLabelCell*)[cellObjects objectAtIndex:0];
        }
        DetailInfoModel *dim = [[DetailInfoModel alloc]init];
        if ([DataManager sharedInstance].detailViewModel) {
             dim = [DataManager sharedInstance].detailViewModel.Table1[0];
        }
        
        switch (indexPath.row) {
            case 0:
                cell.imgView.image = [UIImage imageNamed:@"code"];
                cell.firstLabel.text = @"Equipment Code";
                cell.secondLabel.text = dim.equipmentcode;
                
                break;
            case 1:
                cell.imgView.image = [UIImage imageNamed:@"name"];
                cell.firstLabel.text = @"Equipment Name";
                cell.secondLabel.text = dim.equipmentname;
                break;
            case 2:
                cell.imgView.image = [UIImage imageNamed:@"brand"];
                cell.firstLabel.text = @"Brand";
                cell.secondLabel.text = dim.trademark;
                break;
            case 3:
                cell.imgView.image = [UIImage imageNamed:@"model"];
                cell.firstLabel.text = @"Model";
                
                cell.secondLabel.text = dim.type;
                break;
            case 4:
                cell.imgView.image = [UIImage imageNamed:@"specification"];
                cell.firstLabel.text = @"Specification";
                cell.secondLabel.text = dim.specification;
                break;
            case 5:
                cell.imgView.image = [UIImage imageNamed:@"supplier"];
                cell.firstLabel.text = @"Supplier";
                cell.secondLabel.text = dim.provider;
                break;
            case 6:
                cell.imgView.image = [UIImage imageNamed:@"purchase_date"];
                cell.firstLabel.text = @"Procurement Date";
                cell.secondLabel.text = dim.procurementdate;
                break;
            case 7:
                cell.imgView.image = [UIImage imageNamed:@"batch_number"];
                cell.firstLabel.text = @"Batch No.";
                cell.secondLabel.text = dim.batchnumbe;
                break;
            case 8:
                cell.imgView.image = [UIImage imageNamed:@"location"];
                cell.firstLabel.text = @"Location";
                cell.secondLabel.text = dim.placementposition;
                break;
            case 9:
                cell.imgView.image = [UIImage imageNamed:@"equipment_category"];
                cell.firstLabel.text = @"Equipment Category";
                cell.secondLabel.text = dim.equipmenttype;
                break;
            case 10:
                cell.imgView.image = [UIImage imageNamed:@"super_equipment"];
                cell.firstLabel.text = @"Super Equipment";
                cell.secondLabel.text = dim.superequipment;
                break;
            case 11:
                cell.imgView.image = [UIImage imageNamed:@"physical_dimension"];
                cell.firstLabel.text = @"Physical Dimension";
                cell.secondLabel.text = dim.externaldimension;
                break;
            case 12:
                cell.imgView.image = [UIImage imageNamed:@"weight"];
                cell.firstLabel.text = @"Weight";
                cell.secondLabel.text = dim.weight;
                break;
            case 13:
                cell.imgView.image = [UIImage imageNamed:@"producer"];
                cell.firstLabel.text = @"Producer";
                cell.secondLabel.text = dim.manufacture;
                break;
            case 14:
                cell.imgView.image = [UIImage imageNamed:@"production_code"];
                cell.firstLabel.text = @"Production Code";
                cell.secondLabel.text = dim.factorycode;
                break;
            case 15:
                cell.imgView.image = [UIImage imageNamed:@"production_date"];
                cell.firstLabel.text = @"Production Date";
                cell.secondLabel.text = dim.procurementdate;
                break;
            case 16:
                cell.imgView.image = [UIImage imageNamed:@"life_span"];
                cell.firstLabel.text = @"Life Span";
                cell.secondLabel.text = dim.durableyears;
                break;
            case 17:
                cell.imgView.image = [UIImage imageNamed:@"main_specification_fields"];
                cell.firstLabel.text = @"Main Specification Fields";
                cell.secondLabel.text = dim.maintechnicalparameters;
                break;
            case 18:
                cell.imgView.image = [UIImage imageNamed:@"remark"];
                cell.firstLabel.text = @"Remark";
                cell.secondLabel.text = dim.remark;
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        SixLabelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if(cell == nil){
            NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"SixLabelCell" owner:self options:nil];
            cell = (SixLabelCell*)[cellObjects objectAtIndex:0];
        }
        PartsModel *part = [[PartsModel alloc]init];
        if ([DataManager sharedInstance].detailViewModel) {
            part = [DataManager sharedInstance].detailViewModel.Table2[indexPath.row];
        }
        cell.firstLabel.text = part.partsname;
        cell.secondLabel.text = part.subordinateequipment;
        cell.thirdLabel.text = part.specification;
        cell.fourthLabel.text = part.texture;
        cell.fifthLabel.text = part.number;
        cell.sixthLabel.text = part.modificationtime;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.plantTableView) {
        UIView *view = [[UIView alloc]init];
        UIImageView *headerForDetail = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detail"]];
        [view addSubview:headerForDetail];
        headerForDetail.frame = CGRectMake(0, 0, 100, 20);
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    else{
        UIView *view = [[UIView alloc]init];
        UIImageView *headerForParts = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"component"]];
        headerForParts.frame = CGRectMake(0, 0, 100, 20);
        [view addSubview:headerForParts];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[DataManager sharedInstance].currentTF resignFirstResponder];
}
@end
