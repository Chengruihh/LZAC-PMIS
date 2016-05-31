//
//  PlantListInfoView.m
//  PIMS
//
//  Created by ChengRui on 16/5/9.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "PlantListInfoView.h"
#import "CurrentPlantCell.h"
#import "PlantCell.h"
#import "DataManager.h"
#import "BasicInfoView.h"
#import "PlantListModel.h"

@interface PlantListInfoView() <UITableViewDataSource, UITableViewDelegate>
//@property (strong, nonatomic) id expanded;
@property (weak, nonatomic) UITableView *plantListView;
@property (weak, nonatomic) UIView *pathView;
@property (weak, nonatomic) CurrentPlantCell *currentPlantCell;
@end
@implementation PlantListInfoView

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
            PlantListInfoView *subView = [[[NSBundle mainBundle] loadNibNamed:@"PlantListInfoView"
                                                                  owner:self
                                                                options:nil] objectAtIndex:0];
            
            [self addSubview:subView];
        }
        self.frame = [DataManager sharedInstance].midViewFrame;
        CurrentPlantCell *topcell = [[NSBundle mainBundle] loadNibNamed:@"CurrentPlantCell" owner:nil options:nil].firstObject;
        topcell.frame = CGRectMake(0, 40, self.frame.size.width, 80);
        topcell.plantNameLabel.text = [[DataManager sharedInstance].basicViewModel.JiBenXinXi[0] equipmentname];
        topcell.plantCodeLabel.text = [[DataManager sharedInstance].basicViewModel.JiBenXinXi[0] equipmentcode];
        self.currentPlantCell = topcell;
        
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.frame.size.width, self.frame.size.height-180)];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        
        [tableView reloadData];
        
        UIView *path =  [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 30)];
        path.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"path"]];
        self.pathView = path;
        self.plantListView = tableView;
        [self addSubview:path];
        [self addSubview:topcell];
        [self addSubview:tableView];
        
    }
    return self;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [DataManager sharedInstance].plantListViewModel.numberOfChildren;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlantCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"PlantCell" owner:self options:nil];
        cell = (PlantCell*)[cellObjects objectAtIndex:0];
    }
    
    cell.equipmentNameLabel.text = [[DataManager sharedInstance].plantListViewModel.listOfChildrenPlant[indexPath.row] equipmentname];
    cell.equipmentCodeLabel.text = [[DataManager sharedInstance].plantListViewModel.listOfChildrenPlant[indexPath.row] equipmentcode];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[DataManager sharedInstance].currentTF resignFirstResponder];
}

@end
