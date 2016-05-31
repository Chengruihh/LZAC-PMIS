//
//  CodeScanController.m
//  PIMS
//
//  Created by ChengRui on 16/4/21.
//  Copyright © 2016年 LZAC. All rights reserved.
//

#import "CodeScanController.h"
#import "DataManager.h"
#import "BasicViewModel.h"
#import <AVFoundation/AVFoundation.h>

@interface CodeScanController () <AVCaptureMetadataOutputObjectsDelegate>

@property (strong,nonatomic)AVCaptureDevice * device;

@property (strong,nonatomic)AVCaptureDeviceInput * input;

@property (strong,nonatomic)AVCaptureMetadataOutput * output;

@property (strong,nonatomic)AVCaptureSession * session;

@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@end

@implementation CodeScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Device
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    
    _output = [[AVCaptureMetadataOutput alloc]init];
    
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    // Session
    
    _session = [[AVCaptureSession alloc]init];
    
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
        
    {
        
        [_session addInput:self.input];
        
    }
    
    if ([_session canAddOutput:self.output])
        
    {
        
        [_session addOutput:self.output];
        
    }
    
    
    [self checkAVAuthorizationStatus];
    
}
- (void)checkAVAuthorizationStatus{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //    NSString *tips = NSLocalizedString(@"AVAuthorization", @"您没有权限访问相机");
    if(status == AVAuthorizationStatusAuthorized) {
        // authorized
        // 条码类型 AVMetadataObjectTypeQRCode
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        
        
        // Preview
        
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        _preview.frame = self.view.layer.bounds;
        
        [self.view.layer insertSublayer:_preview atIndex:0];
        
        // Start
        
        [_session startRunning];
    } else {
        //        [SVProgressHUD showWithStatus:tips];
        NSLog(@"permission deny");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0){
        
        //停止扫描
        
        [_session stopRunning];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        [DataManager sharedInstance].basicViewModel = [[BasicViewModel alloc]initWithString:metadataObject.stringValue error:nil];
        stringValue = metadataObject.stringValue;
        NSLog(@"%@",stringValue);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"scan_succeed" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeBtnTapped:(id)sender {
    [_session stopRunning];
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
