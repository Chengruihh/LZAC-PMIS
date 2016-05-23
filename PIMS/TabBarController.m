//
//  TabBarController.m
//  PIMS
//
//  Created by ChengRui on 16/4/21.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "TabBarController.h"
#import "LoginController.h"
#import "BasicInfoView.h"
#import "DetailInfoView.h"
#import "PlantListInfoView.h"
#import "DocListView.h"
#import "UserInfoView.h"
#import "CodeScanController.h"
#import "RequestManager.h"
#import "DataManager.h"

@interface TabBarController ()<UITabBarDelegate>
@property (assign, nonatomic) CGRect midViewFrame;
@property (strong, nonatomic) UITabBarItem *lastSelected;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabImages];
    [self setTopViewImages];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scanSucceed) name:@"scan_succeed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchSucceed) name:@"searchSucceed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestBasicSucceed) name:@"requestBasicSucceed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestDetailSucceed) name:@"requestDetailSucceed" object:nil];
    
    self.midViewFrame = CGRectMake(self.midView.frame.origin.x, self.midView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-self.topView.frame.size.height-self.tabbar.frame.size.height-20);
    // Do any additional setup after loading the view.
//    [LoginController presentLoginController:self];
    self.tabbar.selectedItem = nil;
    self.lastSelected = nil;
    self.tabbar.tintColor = [UIColor whiteColor];
    
//    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"BasicInfoView" owner:self options:nil];
//    BasicInfoView *basicInfoView = xibObjects.firstObject;
    UIView *basicInfoView = [[UIView alloc]initWithFrame:self.midViewFrame];
    basicInfoView.frame = self.midViewFrame;
    UIGraphicsBeginImageContext(self.midViewFrame.size);
    [[UIImage imageNamed:@"no_content"] drawInRect:CGRectMake(20, 90, self.midViewFrame.size.width-40, [UIImage imageNamed:@"no_content"].size.height-27)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    basicInfoView.backgroundColor = [UIColor colorWithPatternImage:image];
    self.midView = basicInfoView;
    [self.view addSubview:basicInfoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setTabImages{
    self.detailTab.image = [[UIImage imageNamed:@"tab_detail"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.detailTab.selectedImage = [[UIImage imageNamed:@"tab_detail_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.plantListTab.image = [[UIImage imageNamed:@"tab_plant"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.plantListTab.selectedImage = [[UIImage imageNamed:@"tab_plant_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.docListTab.image = [[UIImage imageNamed:@"tab_doc"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.docListTab.selectedImage = [[UIImage imageNamed:@"tab_doc_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.myTab.image = [[UIImage imageNamed:@"tab_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.myTab.selectedImage = [[UIImage imageNamed:@"tab_my_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)setTopViewImages{
    self.topView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"top_bar_background"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item == self.lastSelected) {
        //do nothing
    }
    else if (item == self.detailTab) {
        self.lastSelected = self.detailTab;
        if ([DataManager sharedInstance].basicViewModel) {
            [[RequestManager sharedInstance]requestDetailInfo:[[DataManager sharedInstance].basicViewModel.JiBenXinXi[0] equipmentcode]];
        }
        else{
            [_midView removeFromSuperview];
            _midView = nil;
            NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailInfoView" owner:self options:nil];
            DetailInfoView *div = xibObjects.firstObject;
            div.frame = self.midViewFrame;
            [self.view addSubview:div];
            self.midView = div;
        }
            
        NSLog(@"1");
    }
    else if (item == self.plantListTab) {
        [_midView removeFromSuperview];
        _midView = nil;
        NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"PlantListInfoView" owner:self options:nil];
        DetailInfoView *pliv = xibObjects.firstObject;
        pliv.frame = self.midViewFrame;
        [self.view addSubview:pliv];
        self.midView = pliv;
        NSLog(@"2");
        self.lastSelected = self.plantListTab;
    }
    else if (item == self.docListTab) {
        [_midView removeFromSuperview];
        _midView = nil;
        NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"DocListView" owner:self options:nil];
        DetailInfoView *dlv = xibObjects.firstObject;
        dlv.frame = self.midViewFrame;
        [self.view addSubview:dlv];
        self.midView = dlv;
        self.lastSelected = self.docListTab;
        NSLog(@"3");
    }
    else if (item == self.myTab) {
        [_midView removeFromSuperview];
        _midView = nil;
        NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil];
        DetailInfoView *uiv = xibObjects.firstObject;
        uiv.frame = self.midViewFrame;
        [self.view addSubview:uiv];
        self.midView = uiv;
        self.lastSelected = self.myTab;
        NSLog(@"4");
    }
}
- (IBAction)scanBtnTapped:(id)sender {
    [self.tabbar setSelectedItem:nil];
    self.lastSelected = nil;
    CodeScanController *scanController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CodeScanController"];
//    scanController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:scanController animated:YES completion:nil];
    
}
- (IBAction)searchBtnTapped:(id)sender {
    if (self.searchTF.text == nil || self.searchTF.text.length==0) {
        //
    }
    else{
        [[RequestManager sharedInstance] searchWithKeyword:self.searchTF.text];
        
    }
}

-(void)scanSucceed{
    [_midView removeFromSuperview];
    _midView = nil;
    [self.tabbar setSelectedItem:nil];
    self.lastSelected = nil;
    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"BasicInfoView" owner:self options:nil];
    BasicInfoView *basicInfoView = xibObjects.firstObject;
    basicInfoView.frame = self.midViewFrame;
    basicInfoView.isSearch = NO;
    self.midView = basicInfoView;
    [self.view addSubview:basicInfoView];
}

-(void)searchSucceed{
    [self.tabbar setSelectedItem:nil];
    self.lastSelected = nil;
    [_midView removeFromSuperview];
    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"BasicInfoView" owner:self options:nil];
    BasicInfoView *basicInfoView = xibObjects.firstObject;
    basicInfoView.frame = self.midViewFrame;
    basicInfoView.isSearch = YES;
    self.midView = basicInfoView;
    [self.view addSubview:basicInfoView];
}

-(void)requestBasicSucceed{
    [_midView removeFromSuperview];
    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"BasicInfoView" owner:self options:nil];
    BasicInfoView *basicInfoView = xibObjects.firstObject;
    basicInfoView.frame = self.midViewFrame;
    basicInfoView.isSearch = NO;
    self.midView = basicInfoView;
    [self.view addSubview:basicInfoView];
}

-(void)requestDetailSucceed{
    [_midView removeFromSuperview];
    _midView = nil;
    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailInfoView" owner:self options:nil];
    DetailInfoView *div = xibObjects.firstObject;
    div.frame = self.midViewFrame;
    [self.view addSubview:div];
    self.midView = div;
    
    
}
@end
