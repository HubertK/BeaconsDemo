//
//  BeaconInfoController.h
//  BeaconsDemo
//
//  Created by Kunnemeyer, Hubert on 7/29/14.
//  Copyright (c) 2014 webmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTBeaconManager.h"
#import "ESTBeacon.h"

@interface BeaconInfoController : UITableViewController
@property (strong, nonatomic) ESTBeacon *beacon;

@end
