//
//  ViewController.m
//  geoPhence
//
//  Created by Joerg Burbach on 11.01.17.
//  Copyright © 2017 onewolf games. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation ViewController

@synthesize locationManager;
@synthesize log_text;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // Initialize the Locationmanager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    // get the current position
    [locationManager startUpdatingLocation];
    
    // request authorisation
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];

    // add a geoPhence
    
    /* Brüsseler Straße 94, Köln: 50.9405826,6.9328591 */

    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(50.9405826,6.9328591);
    CLRegion *office = [[CLCircularRegion alloc]initWithCenter:center
                                                        radius:20.0
                                                    identifier:@"Büro"];
    office.notifyOnExit = YES;
    office.notifyOnEntry = YES;
    
    // Add the geoPhence
    [locationManager startMonitoringForRegion:office];
    
    // Testszene: https://www.mydevolo.com/v1/hc/gateways/1409301750002167/scenes/Testszene?key=6b67fce17abb136b3d1c859dffe00050&uuid=1C572F2B-F085-469D-82DA-545A3956E4D2
//    NSString *urlString = @"https://www.mydevolo.com/v1/hc/gateways/1409301750002167/scenes/Testszene?key=6b67fce17abb136b3d1c859dffe00050&uuid=1C572F2B-F085-469D-82DA-545A3956E4D2";
//    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    log_text.text = [log_text.text stringByAppendingString:[NSString stringWithFormat:@"\nLeft region: %@", [locations lastObject]]];
}


- (void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    log_text.text = [log_text.text stringByAppendingString:[NSString stringWithFormat:@"\nEntered region: %@", region]];

    // https://www.mydevolo.com/v1/hc/gateways/1409301750002167/scenes/Ankunft?key=6b67fce17abb136b3d1c859dffe00050&uuid=7AA0A0A2-4679-4530-9386-07D0B1016B6F
//    NSString *urlString = @"https://www.mydevolo.com/v1/hc/gateways/1409301750002167/scenes/Ankunft?key=6b67fce17abb136b3d1c859dffe00050&uuid=7AA0A0A2-4679-4530-9386-07D0B1016B6F";
//    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
}

- (void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    log_text.text = [log_text.text stringByAppendingString:[NSString stringWithFormat:@"\nLeft region: %@", region]];
    
    // https://www.mydevolo.com/v1/hc/gateways/1409301750002167/scenes/Verlassen?key=6b67fce17abb136b3d1c859dffe00050&uuid=DC036078-4150-4C27-B402-E3DE5FAFECA8

    NSString *urlString = @"https://www.mydevolo.com/v1/hc/gateways/1409301750002167/scenes/Verlassen?key=6b67fce17abb136b3d1c859dffe00050&uuid=DC036078-4150-4C27-B402-E3DE5FAFECA8";
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
}

@end
