//
//  ViewController.m
//  MKDirectionsDemo(获取导航路线信息)
//
//  Created by Lucky on 15/9/11.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MapViewViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CLGeocoder *geocoder;

- (IBAction)startNavigation;
/**
 *  开始位置
 */
@property (weak, nonatomic) IBOutlet UITextField *startField;
/**
 *  结束位置
 */
@property (weak, nonatomic) IBOutlet UITextField *endField;


@end


@implementation ViewController

- (void)startNavigation
{
    if (self.startField.text == nil || self.startField.text.length == 0 || self.endField.text == 0 || self.endField.text.length == 0) {
        return;
    }
    
    [self.geocoder geocodeAddressString:self.startField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *startMark = [placemarks firstObject];
        
        [self.geocoder geocodeAddressString:self.endField.text completionHandler:^(NSArray *placemarks, NSError *error) {
            
            CLPlacemark *endMark = [placemarks firstObject];
            
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
            
            request.source = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithPlacemark:startMark]];
            
            request.destination = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithPlacemark:endMark]];
            
            MKDirections *directicons = [[MKDirections alloc] initWithRequest:request];
            
            [directicons calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                
                MapViewViewController *mc = [[MapViewViewController alloc] init];
                
                mc.response = response;
                
                [self presentViewController:mc animated:YES completion:nil];
                
                NSArray *routes = response.routes;
                
                for (MKRoute *route in routes) {
                    
                    NSLog(@"%f千米, %f小时", route.distance/1000, route.expectedTravelTime/3600);
                    
                    NSArray *steps = route.steps;
                    
                    for (MKRouteStep *step in steps) {
                        NSLog(@"%@, %f", step.instructions, step.distance);
                    }
                    
                }
                
            }];
            
        }];
        
    }];
    
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



@end
