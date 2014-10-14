//
//  WSMotionManager.m
//  wrkstrm
//
//  Created by Cristian A Monterroza on 3/22/13.
//  Copyright (c) 2013 wrkstrm. All rights reserved.
//

#import "WSMMotionManager.h"
#import <WSMUtilities/WSMUtilities.h>

@interface WSMMotionManager ()

@property (nonatomic , strong) NSMutableDictionary *timerDictionary;

@property (nonatomic, strong, readwrite) RACSubject *motionSubject;

+ (NSOperationQueue *) sharedQueue;

@end

@implementation WSMMotionManager

+ (WSMMotionManager *) sharedManager {
    static WSMMotionManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedManager = [WSMMotionManager new]; });
    return sharedManager;
}

+ (NSOperationQueue *) sharedQueue {
    static NSOperationQueue *sharedQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedQueue = [NSOperationQueue new]; });
    return sharedQueue;
}

- (id) init {
    if (!(self = [super init])) return nil;
    self.deviceMotionUpdateInterval = 1.0f / 4.0f;
    [self startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical
                                              toQueue:[WSMMotionManager sharedQueue]
                                          withHandler:^(CMDeviceMotion *motion, NSError *error)
     {
         [self.motionSubject sendNext:motion];
     }];
    
    return self;
}

- (RACSubject *)motionSubject {
    return WSM_LAZY(_motionSubject, [RACSubject subject]);
}

@end