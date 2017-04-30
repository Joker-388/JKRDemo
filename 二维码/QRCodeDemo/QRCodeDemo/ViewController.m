//
//  ViewController.m
//  QRCodeDemo
//
//  Created by Lucky on 16/3/21.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //创建扫描会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    
    //给扫描会话添加输入（摄像头）
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"无法创建输入端");
        return;
    }
    [session addInput:inputDevice];
    
    //给扫描会话添加输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //设置扫描的区域
    [output setRectOfInterest:CGRectMake(124 / [UIScreen mainScreen].bounds.size.height, ([UIScreen mainScreen].bounds.size.width - 220) / 2 / [UIScreen mainScreen].bounds.size.width, 220 / [UIScreen mainScreen].bounds.size.height, 220 / [UIScreen mainScreen].bounds.size.width)];
    
    //设置扫描界面
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    layer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
    //开始扫描
    [session startRunning];
    
    UIView *backgroud = [[UIView alloc] init];
    backgroud.backgroundColor = [UIColor clearColor];
    backgroud.layer.borderWidth = 3;
    backgroud.layer.borderColor = [UIColor redColor].CGColor;
    backgroud.frame = CGRectMake(0, 0, 220, 220);
    backgroud.center = self.view.center;
    CGRect frame = backgroud.frame;
    frame.origin.y = 124;
    backgroud.frame = frame;
    
    [self.view addSubview:backgroud];
}

//扫描区域边框
- (void)viewWillAppear:(BOOL)animated
{
    
}

//扫描回调
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"%@", object.stringValue);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:object.stringValue]];
        
        [self.session stopRunning];

        [self.layer removeFromSuperlayer];
    }
}

@end
