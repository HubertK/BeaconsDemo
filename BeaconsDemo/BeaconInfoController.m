//
//  BeaconInfoController.m
//  BeaconsDemo
//
//  Created by Kunnemeyer, Hubert on 7/29/14.
//  Copyright (c) 2014 webmd. All rights reserved.
//

#import "BeaconInfoController.h"

@interface BeaconInfoController ()<ESTBeaconManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *beaconName;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *poximityLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssi;
@property (strong, nonatomic) ESTBeaconManager *manager;
@property (strong, nonatomic) ESTBeaconRegion *region;
@property (strong, nonatomic) ESTBeacon *foundBeacon;

@end

@implementation BeaconInfoController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.beaconName.text = self.beacon.name;
    _manager = [[ESTBeaconManager alloc]init];
    _manager.delegate = self;
    
    _region = [[ESTBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID
                                                       major:[self.beacon.major unsignedIntValue]
                                                       minor:[self.beacon.minor unsignedIntValue]
                                                  identifier:@"RegionIdentifier"];
    
    [_manager startRangingBeaconsInRegion:_region];
}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region{
    ESTBeacon *beacon = [beacons firstObject];
    NSLog(@"Beacon:%@",beacon);
    
    if ([beacon isEqualToBeacon:self.beacon]) {
        self.foundBeacon = beacon;
        self.distanceLabel.text = [NSString stringWithFormat:@"%@",beacon.distance];
        self.poximityLabel.text = [NSString stringWithFormat:@"%@",[self strngForProximity:beacon.proximity]];
        self.rssi.text = [NSString stringWithFormat:@"%ld",(long)beacon.rssi];
    }
}
- (NSString *)strngForProximity:(CLProximity)proximity{
    switch (proximity) {
        case CLProximityUnknown:
            return @"Unknown";
            break;
        case CLProximityImmediate:
            return @"Close";
            break;
        case CLProximityNear:
            return @"Near";
            break;
        case CLProximityFar:
            return @"Far away";
            break;
        default:
            return nil;
            break;
    }
}












@end
