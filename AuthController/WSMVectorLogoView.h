//
//  WSVectorLogoView.h
//  StarterPack
//
//  Created by Cristian A Monterroza on 1/11/13.
//  Copyright (c) 2013 wrkstrm. All rights reserved.
//

#import "AppDelegate.h"
#import "WSMGravityButton.h"

@interface WSMVectorLogoView : WSMGravityButton

- (void)scaleToRect:(CGRect)rect;

- (void)scaleByFactor:(CGFloat)scaleFactor;

- (void)pulseView:(BOOL)pulse;

- (void)pulseView:(BOOL)pulse withDelay:(CGFloat)delay;

@end