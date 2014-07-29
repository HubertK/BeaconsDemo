//
//  BeaconCell.h
//  BeaconsDemo
//
//  Created by Kunnemeyer, Hubert on 7/29/14.
//  Copyright (c) 2014 webmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeaconCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *major;
@property (weak, nonatomic) IBOutlet UILabel *minor;

@end
