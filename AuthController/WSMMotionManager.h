//
//  WSMotionManager.h
//  wrkstrm
//
//  Created by Cristian A Monterroza on 3/22/13.
//  Copyright (c) 2013 wrkstrm. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface WSMMotionManager : CMMotionManager

+ (WSMMotionManager *) sharedManager;

@property (nonatomic, strong) CMDeviceMotion *currentMotion;

@property (nonatomic, strong, readonly) RACSubject *motionSubject;

@end