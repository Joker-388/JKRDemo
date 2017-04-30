//
//  ViewController.m
//  ReverseGeocoder
//
//  Created by Lucky on 15/9/10.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

- (IBAction)reverseGeocoderBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *longtitudeField;

@property (weak, nonatomic) IBOutlet UITextField *latitudeField;

@property (weak, nonatomic) IBOutlet UILabel *reverseDetailAddreddLabel;

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.reverseDetailAddreddLabel.layer.cornerRadius = 10;
    self.reverseDetailAddreddLabel.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (IBAction)reverseGeocoderBtnClick:(UIButton *)sender {
    
    if (self.longtitudeField.text == nil && self.longtitudeField.text.length == 0 && self.latitudeField.text == nil && self.latitudeField.text.length == 0) {
        return;
    }
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.latitudeField.text doubleValue] longitude:[self.longtitudeField.text doubleValue]];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks lastObject];
        
        NSLog(@"%@, %@, %f, %f", placemark.name, placemark.addressDictionary, placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
//        self.reverseDetailAddreddLabel.text = placemark.locality;
        NSArray *addAry = placemark.addressDictionary[@"FormattedAddressLines"];
        NSMutableString *addStr = [NSMutableString string];
        for (NSString *str in addAry) {
            [addStr appendString:str];
        }
        self.reverseDetailAddreddLabel.text = addStr;
    }];
    
}
@end
