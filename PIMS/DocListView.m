//
//  DocListView.m
//  PIMS
//
//  Created by ChengRui on 16/5/9.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "DocListView.h"
#import "RATreeView.h"
#import "DataManager.h"
#import "Folder.h"
#import "Document.h"
#import "DocumentCell.h"
#import "FolderCell.h"
#import "PDFViewController.h"
#import "BasicInfoView.h"

@interface DocListView() <RATreeViewDelegate, RATreeViewDataSource>
//@property (strong, nonatomic) id expanded;
@property (weak, nonatomic) RATreeView *treeView;
@property (weak, nonatomic) UIView *pathView;
@property (strong, nonatomic) UILabel *pathLabel;
@end
@implementation DocListView

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
            DocListView *subView = [[[NSBundle mainBundle] loadNibNamed:@"DocListView"
                                                                  owner:self
                                                                options:nil] objectAtIndex:0];
            
            
            [self addSubview:subView];
        }
        self.frame = [DataManager sharedInstance].midViewFrame;
        RATreeView *treeView = [[RATreeView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-40)];
        
        treeView.delegate = self;
        treeView.dataSource = self;
        treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
        
        [treeView reloadData];
        
        
        self.pathLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width, 30)];
        NSString *plantName = [[DataManager sharedInstance].basicViewModel.JiBenXinXi[0] equipmentname];
        self.pathLabel.text = [NSString stringWithFormat:@"Path: %@ / ", plantName ? plantName : @""] ;
        self.pathLabel.textColor = [UIColor whiteColor];
        self.pathLabel.font = [UIFont systemFontOfSize:12];
        UIView *path =  [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 30)];
        path.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"path"]];
        
        [path addSubview:self.pathLabel];
        self.pathView = path;
        self.treeView = treeView;
        [self addSubview:path];
        [self addSubview:treeView];
    }
    self.treeView.treeFooterView=[[UIView alloc]init];
    return self;
    
}

#pragma mark TreeView Delegate methods
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    if (treeNodeInfo.treeDepthLevel == 0) {
    return 90;
    }
    else
        return 50;
}

- (NSInteger)treeView:(RATreeView *)treeView indentationLevelForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return 3 * treeNodeInfo.treeDepthLevel;
}

- (BOOL)treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return YES;
}

- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel{
    //    if ([item isEqual:self.expanded]) {
    //        return YES;
    //    }
    return NO;
}

- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    //    if (treeNodeInfo.treeDepthLevel == 0) {
    //        cell.backgroundColor = UIColorFromRGB(0xF7F7F7);
    //    } else if (treeNodeInfo.treeDepthLevel == 1) {
    //        cell.backgroundColor = UIColorFromRGB(0xD1EEFC);
    //    } else if (treeNodeInfo.treeDepthLevel == 2) {
    //        cell.backgroundColor = UIColorFromRGB(0xE0F8D8);
    //    }
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    NSInteger numberOfChildren = [treeNodeInfo.children count];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of children %ld", (long)numberOfChildren];
    
    if (treeNodeInfo.treeDepthLevel == 0) {
        NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"FolderCell" owner:self options:nil];
        FolderCell *folderCell = cellObjects.firstObject;
        folderCell.folderNameLabel.text = ((Folder *)item).folderName;
        folderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return folderCell;
    }else{
        NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"DocumentCell" owner:self options:nil];
        DocumentCell *docCell = cellObjects.firstObject;
        
        docCell.docNameLabel.text = ((Document *)item).docName;
        docCell.docSizeLabel.text = ((Document *)item).docSize;
        docCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return docCell;
    }
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item{
    if (item == nil) {
        return [DataManager sharedInstance].docListViewModel.folderList.count;
    }
    if ([item isKindOfClass:[Folder class]]) {
        return ((Folder *)item).documentList.count;
    }else{
        return 0;
    }
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item{
    Folder *folder = item;
    if (item == nil) {
        return [DataManager sharedInstance].docListViewModel.folderList[index];
    }
    return folder.documentList[index];
}

-(void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    if ([item isKindOfClass:[Document class]]) {
        [DataManager sharedInstance].selectedDocUrl = ((Document *)item).docURL;
        [self.delegate loadPDFViewForDocument];
    }
    else if([item isKindOfClass:[Folder class]]){
        if ([treeNodeInfo isExpanded]) {
            [self.pathLabel removeFromSuperview];
            self.pathLabel.text = [NSString stringWithFormat:@"Path: %@ /", [[DataManager sharedInstance].basicViewModel.JiBenXinXi[0] equipmentname]];
            [self.pathView addSubview:self.pathLabel];
        }else{
            [self.pathLabel removeFromSuperview];
            self.pathLabel.text = [NSString stringWithFormat:@"Path: %@ / %@", [[DataManager sharedInstance].basicViewModel.JiBenXinXi[0] equipmentname], ((Folder *)item).folderName];
            [self.pathView addSubview:self.pathLabel];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[DataManager sharedInstance].currentTF resignFirstResponder];
}
@end
