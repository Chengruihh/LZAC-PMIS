//
//  PDFViewController.m
//  PIMS
//
//  Created by ChengRui on 16/5/30.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "PDFViewController.h"
#import "DataManager.h"
#import "ActivityIndicator.h"

@interface PDFViewController ()<UIWebViewDelegate>

@end

@implementation PDFViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [ActivityIndicator startActivityIndicator:self];
    NSURL *url = [NSURL URLWithString:[DataManager sharedInstance].selectedDocUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.pdfView.scalesPageToFit=YES;
    [self.pdfView loadRequest:request];
    self.pdfView.delegate = self;
    self.isPresented = YES;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [ActivityIndicator stopActivityIndicator:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnTapped:(id)sender {
    self.isPresented = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
