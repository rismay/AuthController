//
//  WSGravityView.h
//  wrkstrm
//
//  Created by Cristian A Monterroza on 3/22/13.
//  Copyright (c) 2013 wrkstrm. All rights reserved.
//

#import "AppDelegate.h"
#import "WSMMotionManager.h"

@interface WSMGravityButton : UIButton

//Instance variables necessary to create the offset.
@property (nonatomic) CMAcceleration gravityMultiplier;
@property (nonatomic) CGFloat shadowOffset;

@property (nonatomic) CGSize lightShadowOffset;
@property (nonatomic) BOOL animating;

- (void)commonInitializer;

@end
