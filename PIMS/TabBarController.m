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
#import "ActivityIndicator.h"
#import "Helper.h"
#import "PDFViewController.h"

@interface TabBarController ()<UITabBarDelegate, DocumentDelegate, SearchDelegate, UITextFieldDelegate>
@property (strong, nonatomic) UITabBarItem *lastSelected;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestDocListSucceed) name:@"requestDocListSucceed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestPlantListSucceed) name:@"requestPlantListSucceed" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestFailed) name:@"searchFailed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestFailed) name:@"requestBasicFailed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestFailed) name:@"requestDetailFailed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestFailed) name:@"requestDocListFailed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestFailed) name:@"requestPlantListFailed" object:nil];
    
    [DataManager sharedInstance].midViewFrame = CGRectMake(self.midView.frame.origin.x, self.midView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-self.topView.frame.size.height-self.tabbar.frame.size.height-20);
    
    self.tabbar.selectedItem = nil;
    self.lastSelected = nil;
    self.tabbar.tintColor = [UIColor whiteColor];
    self.searchTF.delegate = self;
    
    
//    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"BasicInfoView" owner:self options:nil];
//    BasicInfoView *basicInfoView = xibObjects.firstObject;
    UIView *basicInfoView = [[UIView alloc]initWithFrame:[DataManager sharedInstance].midViewFrame];
    basicInfoView.frame = [DataManager sharedInstance].midViewFrame;
    UIGraphicsBeginImageContext([DataManager sharedInstance].midViewFrame.size);
    [[UIImage imageNamed:@"no_content"] drawInRect:CGRectMake(40, 90, [DataManager sharedInstance].midViewFrame.size.width-80, [UIImage imageNamed:@"no_content"].size.height-54)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    basicInfoView.backgroundColor = [UIColor colorWithPatternImage:image];
    self.midView = basicInfoView;
    [self.view addSubview:basicInfoView];
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    self.tapGesture.numberOfTapsRequired = 1;
    [self.midView addGestureRecognizer:self.tapGesture];
    [DataManager sharedInstance].tabController = self;
    [self performSelectorOnMainThread:@selector(login)withObject:nil waitUntilDone:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setTabImages{
    self.detailTab.image = [[UIImage imageNamed:@"tab_detail"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.detailTab.selectedImage = [[UIImage imageNamed:@"tab_detail_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.detailTab setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.plantListTab.image = [[UIImage imageNamed:@"tab_plant"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.plantListTab.selectedImage = [[UIImage imageNamed:@"tab_plant_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.plantListTab setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.docListTab.image = [[UIImage imageNamed:@"tab_doc"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.docListTab.selectedImage = [[UIImage imageNamed:@"tab_doc_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.docListTab setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.myTab.image = [[UIImage imageNamed:@"tab_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.myTab.selectedImage = [[UIImage imageNamed:@"tab_my_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.myTab setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
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
            [ActivityIndicator startActivityIndicator:self];
            [[RequestManager sharedInstance]requestDetailInfo:[[DataManager sharedInstance].basicViewModel.JiBenXinXi[0] equipmentcode]];
        }
        else{
            [_midView removeFromSuperview];
            _midView = nil;
            NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailInfoView" owner:self options:nil];
            DetailInfoView *div = xibObjects.firstObject;
            div.frame = [DataManager sharedInstance].midViewFrame;
            [self.view addSubview:div];
            self.midView = div;
            [self.midView addGestureRecognizer:self.tapGesture];
        }
            
        NSLog(@"1");
    }
    else if (item == self.plantListTab) {
        if ([DataManager sharedInstance].basicViewModel) {
            [ActivityIndicator startActivityIndicator:self];
            [[RequestManager sharedInstance]requestPlantList:[[DataManager sharedInstance].basicViewModel.JiBenXinXi[0] equipmentcode]];
        }else{
            [_midView removeFromSuperview];
            _midView = nil;
            NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"PlantListInfoView" owner:self options:nil];
            DetailInfoView *pliv = xibObjects.firstObject;
            pliv.frame = [DataManager sharedInstance].midViewFrame;
            [self.view addSubview:pliv];
            self.midView = pliv;
            [self.midView addGestureRecognizer:self.tapGesture];
        }
        NSLog(@"2");
        self.lastSelected = self.plantListTab;
    }
    else if (item == self.docListTab) {
        if ([DataManager sharedInstance].basicViewModel) {
            [ActivityIndicator startActivityIndicator:self];
            [[RequestManager sharedInstance]requestDocList:[[DataManager sharedInstance].basicViewModel.JiBenXinXi[0] equipmentcode]];
        }else{
            [_midView removeFromSuperview];
            _midView = nil;
            NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"DocListView" owner:self options:nil];
            DocListView *dlv = xibObjects.firstObject;
            dlv.frame = [DataManager sharedInstance].midViewFrame;
            [self.view addSubview:dlv];
            self.midView = dlv;
            [self.midView addGestureRecognizer:self.tapGesture];
        }
        self.lastSelected = self.docListTab;
        NSLog(@"3");
    }
    else if (item == self.myTab) {
        [_midView removeFromSuperview];
        _midView = nil;
        NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil];
        DetailInfoView *uiv = xibObjects.firstObject;
        uiv.frame = [DataManager sharedInstance].midViewFrame;
        [self.view addSubview:uiv];
        self.midView = uiv;
        [self.midView addGestureRecognizer:self.tapGesture];
        self.lastSelected = self.myTab;
        NSLog(@"4");
    }
}
- (IBAction)scanBtnTapped:(id)sender {
    [self hideKeyboard];
    [self.tabbar setSelectedItem:nil];
    self.lastSelected = nil;
    CodeScanController *scanController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CodeScanController"];
    [self presentViewController:scanController animated:YES completion:nil];
    
}
- (IBAction)searchBtnTapped:(id)sender {
    [self hideKeyboard];
    if (self.searchTF.text == nil || self.searchTF.text.length < 3) {
        [Helper showTextView:@"Please enter at least 3 characters." withView:self.view];
    }
    else{
        [ActivityIndicator startActivityIndicator:self];
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
    basicInfoView.frame = [DataManager sharedInstance].midViewFrame;
    basicInfoView.isSearch = NO;
    self.midView = basicInfoView;
    [self.view addSubview:basicInfoView];
    [ActivityIndicator stopActivityIndicator:self];
}

-(void)searchSucceed{
    [self.tabbar setSelectedItem:nil];
    self.lastSelected = nil;
    [_midView removeFromSuperview];
    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"BasicInfoView" owner:self options:nil];
    BasicInfoView *basicInfoView = xibObjects.firstObject;
    basicInfoView.frame = [DataManager sharedInstance].midViewFrame;
    basicInfoView.isSearch = YES;
    self.midView = basicInfoView;
    basicInfoView.delegate = self;
    [self.view addSubview:basicInfoView];
    [ActivityIndicator stopActivityIndicator:self];
}

-(void)requestBasicSucceed{
    [_midView removeFromSuperview];
    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"BasicInfoView" owner:self options:nil];
    BasicInfoView *basicInfoView = xibObjects.firstObject;
    basicInfoView.frame = [DataManager sharedInstance].midViewFrame;
    basicInfoView.isSearch = NO;
    self.midView = basicInfoView;
    [self.view addSubview:basicInfoView];
    [ActivityIndicator stopActivityIndicator:self];
}

-(void)requestDetailSucceed{
    [_midView removeFromSuperview];
    _midView = nil;
    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailInfoView" owner:self options:nil];
    DetailInfoView *div = xibObjects.firstObject;
    div.frame = [DataManager sharedInstance].midViewFrame;
    [self.view addSubview:div];
    self.midView = div;
    [ActivityIndicator stopActivityIndicator:self];
    
}

-(void)requestDocListSucceed{
    [_midView removeFromSuperview];
    _midView = nil;
    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"DocListView" owner:self options:nil];
    DocListView *dlv = xibObjects.firstObject;
    dlv.frame = [DataManager sharedInstance].midViewFrame;
    dlv.delegate = self;
    [self.view addSubview:dlv];
    self.midView = dlv;
    [ActivityIndicator stopActivityIndicator:self];
}
-(void)requestPlantListSucceed{
    [_midView removeFromSuperview];
    _midView = nil;
    NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:@"PlantListInfoView" owner:self options:nil];
    PlantListInfoView *plv = xibObjects.firstObject;
    plv.frame = [DataManager sharedInstance].midViewFrame;
    [self.view addSubview:plv];
    self.midView = plv;
    [ActivityIndicator stopActivityIndicator:self];
}

-(void)loadPDFViewForDocument{
    PDFViewController *pdfViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PDFViewController"];
    [self presentViewController:pdfViewController animated:YES completion:nil];
}

-(void)hideKeyboard{
    [[DataManager sharedInstance].currentTF resignFirstResponder];
}

-(void)showActivityIndicator{
    [ActivityIndicator startActivityIndicator:self];
}

-(void)login{
    [LoginController presentLoginController:self];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [DataManager sharedInstance].currentTF = textField;
    return YES;
}

-(void)requestFailed{
    [Helper showTextView:@"Connection failed, please check your network." withView:self.view];
}


@end
