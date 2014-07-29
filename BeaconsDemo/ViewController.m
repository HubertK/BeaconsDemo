//
//  ViewController.m
//  BeaconsDemo
//
//  Created by Kunnemeyer, Hubert on 7/29/14.
//  Copyright (c) 2014 webmd. All rights reserved.
//

#import "ViewController.h"
#import "ESTBeaconManager.h"
#import "BeaconCell.h"
#import "ESTBeaconVO.h"

#import "BeaconInfoController.h"


static NSString *WEBMD_BEACON_IDENTIFIER = @"WebMDBeaconIdentifier";
static NSString *APP_ID = @"app_0gayndz1ej";
static NSString *APP_TOKEN = @"eb8f3cadc1e903b44b1da309baa6079e";

@interface ViewController ()<ESTBeaconManagerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) ESTBeaconManager *manager;
@property (strong, nonatomic) ESTBeaconRegion *region;
@property (strong, nonatomic) NSArray *ourBeacons; // BeaconVO array
@property (strong, nonatomic) NSMutableArray *foundBeacons;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];

	self.manager = [[ESTBeaconManager alloc]init];
    self.manager.delegate = self;
    self.region = [[ESTBeaconRegion alloc]initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:WEBMD_BEACON_IDENTIFIER];
    [self.manager startRangingBeaconsInRegion:self.region];

    [ESTBeaconManager setupAppID:APP_ID andAppToken:APP_TOKEN];

    [self.manager fetchEstimoteBeaconsWithCompletion:^(NSArray *value, NSError *error) {
        NSLog(@"Fetched Beacons:%@",value);
        if ([value count]) {
            self.ourBeacons = [NSArray arrayWithArray:value];
            //save our beacons
            [self.collectionView reloadData];
            
                  }
    }];
    
    
//    [self.collectionView registerClass:[BeaconCell class] forCellWithReuseIdentifier:@"BeaconCell"];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - ESTBeaconManager Delegate
- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region{
    if (!self.foundBeacons){
        NSLog(@"Seeting found beacons:\n %@",beacons);
        self.foundBeacons = [NSMutableArray arrayWithArray:beacons];
    }
}
- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region{
    NSLog(@"dicovered");
}

#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.ourBeacons count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BeaconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BeaconCell" forIndexPath:indexPath];
    
    ESTBeaconVO *beacon = self.ourBeacons[indexPath.row];
    cell.nameLabel.text = beacon.name;
    cell.major.text = [NSString stringWithFormat:@"%@",beacon.major];
    cell.minor.text = [NSString stringWithFormat:@"%@",beacon.minor];
    
    return cell;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ESTBeaconVO *selected = self.ourBeacons[indexPath.row];
    ESTBeacon *matchingBeacon;
    for (ESTBeacon *aBeacon in self.foundBeacons) {
        if ([aBeacon.minor isEqualToNumber:selected.minor]) {
            //found match
            NSLog(@"Found the correct beacon");
            matchingBeacon = aBeacon;
            [self.manager stopRangingBeaconsInAllRegions];
            [self performSegueWithIdentifier:@"info" sender:matchingBeacon];
            break;
        }
    }
   

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ESTBeacon *beacon = (ESTBeacon *)sender;
    [segue.destinationViewController setBeacon:beacon];
  
}














@end
