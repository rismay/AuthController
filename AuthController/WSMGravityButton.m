//
//  WSGravityView.m
//  wrkstrm
//
//  Created by Cristian A Monterroza on 3/22/13.
//  Copyright (c) 2013 wrkstrm. All rights reserved.
//

#import "WSMGravityButton.h"
#import <ReactiveCocoa/RACEXTScope.h>

@implementation WSMGravityButton

- (void)commonInitializer {
    [self startMonitoringMotion];
    self.backgroundColor = [UIColor clearColor];
}

- (void)startMonitoringMotion {
    @weakify(self);
    [[WSMMotionManager.sharedManager.motionSubject takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(CMDeviceMotion *deviceMotion)
     {
         @strongify(self);
         CMAcceleration newGravity = deviceMotion.gravity;
         CGFloat xGravDelta = fabs(self.shadowOffset * (self.gravityMultiplier.x - newGravity.x));
         CGFloat yGravDelta = fabs(self.shadowOffset * (self.gravityMultiplier.y - newGravity.y));
         if (xGravDelta > 0.5f || yGravDelta > 0.5f) {
             self.gravityMultiplier = newGravity;
             self.lightShadowOffset = CGSizeMake(self.shadowOffset * self.gravityMultiplier.x,
                                                 -self.shadowOffset * self.gravityMultiplier.y);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self setNeedsDisplay];
             });
         }
     }];
}

@end