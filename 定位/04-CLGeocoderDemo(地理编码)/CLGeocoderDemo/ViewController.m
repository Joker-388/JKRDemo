//
//  ViewController.m
//  CLGeocoderDemo
//
//  Created by Lucky on 15/9/10.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addressField;

@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

- (IBAction)geocoderBtnClick:(UIButton *)sender;

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)geocoderBtnClick:(UIButton *)sender {
    
    if (self.addressField.text == nil && self.addressField.text.length == 0) {
        return;
    }
    
    NSString *locationStr = self.addressField.text;
    
    [self.geocoder geocodeAddressString:locationStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks lastObject];
        NSLog(@"%@", placeMark.addressDictionary);
        
        self.latitudeLabel.text = [NSString stringWithFormat:@"%f", placeMark.location.coordinate.latitude];
        self.longitudeLabel.text = [NSString stringWithFormat:@"%f", placeMark.location.coordinate.longitude];
        NSArray *addressArr = placeMark.addressDictionary[@"FormattedAddressLines"];
        NSMutableString *addressStr = [NSMutableString string];
        for (NSString *str in addressArr) {
            [addressStr appendString:str];
        }
        
        self.detailAddressLabel.text = addressStr;
        
    }];
    
}
@end
