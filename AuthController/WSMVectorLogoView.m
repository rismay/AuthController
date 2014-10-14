//
//  WSVectorLogoView.m
//  StarterPack
//
//  Created by Cristian A Monterroza on 1/11/13.
//  Copyright (c) 2013 wrkstrm. All rights reserved.
//

#import "WSMVectorLogoView.h"
#import "WSMColorPalette.h"
#import "WSMMotionManager.h"
#import "NSObject+WSMUtilities.h"

#import <CoreMotion/CoreMotion.h>

@interface WSMVectorLogoView ()

@property (nonatomic) CGAffineTransform currentIdentityTransform;

@property (nonatomic, strong) UIBezierPath *leftCirclePath;
@property (nonatomic, strong) UIBezierPath *rightCirclePath;

@property (nonatomic, strong) UIBezierPath *wrkstrPath;
@property (nonatomic, strong) UIBezierPath *mPath;

@property (nonatomic, strong) UIColor *wrkstrmBlue;
@property (nonatomic, strong) UIColor *wrkstrmGreen;

@end

@implementation WSMVectorLogoView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) [self commonInitializer];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) [self commonInitializer];
    return self;
}

- (void)commonInitializer {
    self.currentIdentityTransform = CGAffineTransformIdentity;
    self.shadowOffset = 4.0f;
    
    _leftCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, 153, 153)];
    _rightCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(122, 5, 153, 153)];
    
    _wrkstrmBlue = [WSMColorPalette colorForAgenda:kWSMAgendaTypeSocial
                                         forIndex:0 ofCount:0 reversed:NO];
    _wrkstrmGreen = [WSMColorPalette colorForAgenda:kWSMAgendaTypeWork
                                          forIndex:0 ofCount:0 reversed:NO];
    
    _wrkstrPath = [UIBezierPath bezierPath];
    [_wrkstrPath moveToPoint: CGPointMake(71.89, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(59.25, 102.39)];
    [_wrkstrPath addLineToPoint: CGPointMake(59.09, 102.39)];
    [_wrkstrPath addLineToPoint: CGPointMake(46.29, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(43.78, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(30.9, 102.39)];
    [_wrkstrPath addLineToPoint: CGPointMake(30.74, 102.39)];
    [_wrkstrPath addLineToPoint: CGPointMake(18.35, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(16.81, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(29.69, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(31.95, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(45, 64)];
    [_wrkstrPath addLineToPoint: CGPointMake(45.16, 64)];
    [_wrkstrPath addLineToPoint: CGPointMake(58.12, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(60.22, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(73.51, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(71.89, 62.38)];
    [_wrkstrPath closePath];
    [_wrkstrPath moveToPoint: CGPointMake(78.94, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(78.94, 80.44)];
    [_wrkstrPath addCurveToPoint: CGPointMake(79.91, 73.8) controlPoint1: CGPointMake(78.94, 78.17) controlPoint2: CGPointMake(79.26, 75.96)];
    [_wrkstrPath addCurveToPoint: CGPointMake(82.9, 68.09) controlPoint1: CGPointMake(80.56, 71.64) controlPoint2: CGPointMake(81.55, 69.73)];
    [_wrkstrPath addCurveToPoint: CGPointMake(88.05, 64.2) controlPoint1: CGPointMake(84.25, 66.44) controlPoint2: CGPointMake(85.97, 65.14)];
    [_wrkstrPath addCurveToPoint: CGPointMake(95.46, 63.02) controlPoint1: CGPointMake(90.13, 63.25) controlPoint2: CGPointMake(92.6, 62.86)];
    [_wrkstrPath addLineToPoint: CGPointMake(95.46, 61.4)];
    [_wrkstrPath addCurveToPoint: CGPointMake(88.94, 62.21) controlPoint1: CGPointMake(92.97, 61.35) controlPoint2: CGPointMake(90.8, 61.62)];
    [_wrkstrPath addCurveToPoint: CGPointMake(84.12, 64.64) controlPoint1: CGPointMake(87.08, 62.81) controlPoint2: CGPointMake(85.47, 63.62)];
    [_wrkstrPath addCurveToPoint: CGPointMake(80.88, 68.25) controlPoint1: CGPointMake(82.77, 65.67) controlPoint2: CGPointMake(81.69, 66.87)];
    [_wrkstrPath addCurveToPoint: CGPointMake(79.1, 72.66) controlPoint1: CGPointMake(80.07, 69.62) controlPoint2: CGPointMake(79.48, 71.1)];
    [_wrkstrPath addLineToPoint: CGPointMake(78.94, 72.66)];
    [_wrkstrPath addLineToPoint: CGPointMake(78.94, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(77.31, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(77.31, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(78.94, 104.01)];
    [_wrkstrPath closePath];
    [_wrkstrPath moveToPoint: CGPointMake(99.91, 88.3)];
    [_wrkstrPath addLineToPoint: CGPointMake(110.69, 79.39)];
    [_wrkstrPath addLineToPoint: CGPointMake(130.21, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(132.39, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(111.9, 78.25)];
    [_wrkstrPath addLineToPoint: CGPointMake(131.02, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(128.67, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(99.91, 86.27)];
    [_wrkstrPath addLineToPoint: CGPointMake(99.91, 46.17)];
    [_wrkstrPath addLineToPoint: CGPointMake(98.29, 46.17)];
    [_wrkstrPath addLineToPoint: CGPointMake(98.29, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(99.91, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(99.91, 88.3)];
    [_wrkstrPath closePath];
    [_wrkstrPath moveToPoint: CGPointMake(161.39, 74.69)];
    [_wrkstrPath addLineToPoint: CGPointMake(163.01, 74.69)];
    [_wrkstrPath addCurveToPoint: CGPointMake(158.96, 64.56) controlPoint1: CGPointMake(163.01, 70.04) controlPoint2: CGPointMake(161.66, 66.67)];
    [_wrkstrPath addCurveToPoint: CGPointMake(147.95, 61.4) controlPoint1: CGPointMake(156.26, 62.46) controlPoint2: CGPointMake(152.59, 61.4)];
    [_wrkstrPath addCurveToPoint: CGPointMake(141.39, 62.38) controlPoint1: CGPointMake(145.35, 61.4) controlPoint2: CGPointMake(143.17, 61.73)];
    [_wrkstrPath addCurveToPoint: CGPointMake(137.01, 64.89) controlPoint1: CGPointMake(139.6, 63.02) controlPoint2: CGPointMake(138.15, 63.86)];
    [_wrkstrPath addCurveToPoint: CGPointMake(134.58, 68.29) controlPoint1: CGPointMake(135.88, 65.91) controlPoint2: CGPointMake(135.07, 67.05)];
    [_wrkstrPath addCurveToPoint: CGPointMake(133.85, 71.85) controlPoint1: CGPointMake(134.1, 69.53) controlPoint2: CGPointMake(133.85, 70.72)];
    [_wrkstrPath addCurveToPoint: CGPointMake(135.07, 77.28) controlPoint1: CGPointMake(133.85, 74.12) controlPoint2: CGPointMake(134.26, 75.93)];
    [_wrkstrPath addCurveToPoint: CGPointMake(138.88, 80.44) controlPoint1: CGPointMake(135.88, 78.63) controlPoint2: CGPointMake(137.15, 79.68)];
    [_wrkstrPath addCurveToPoint: CGPointMake(142.93, 81.9) controlPoint1: CGPointMake(140.06, 80.98) controlPoint2: CGPointMake(141.41, 81.46)];
    [_wrkstrPath addCurveToPoint: CGPointMake(148.19, 83.27) controlPoint1: CGPointMake(144.44, 82.33) controlPoint2: CGPointMake(146.19, 82.79)];
    [_wrkstrPath addCurveToPoint: CGPointMake(153.46, 84.57) controlPoint1: CGPointMake(149.97, 83.7) controlPoint2: CGPointMake(151.73, 84.14)];
    [_wrkstrPath addCurveToPoint: CGPointMake(158.03, 86.31) controlPoint1: CGPointMake(155.18, 85) controlPoint2: CGPointMake(156.71, 85.58)];
    [_wrkstrPath addCurveToPoint: CGPointMake(161.27, 89.11) controlPoint1: CGPointMake(159.35, 87.04) controlPoint2: CGPointMake(160.43, 87.97)];
    [_wrkstrPath addCurveToPoint: CGPointMake(162.53, 93.56) controlPoint1: CGPointMake(162.11, 90.24) controlPoint2: CGPointMake(162.53, 91.72)];
    [_wrkstrPath addCurveToPoint: CGPointMake(161.27, 98.1) controlPoint1: CGPointMake(162.53, 95.34) controlPoint2: CGPointMake(162.11, 96.85)];
    [_wrkstrPath addCurveToPoint: CGPointMake(158.07, 101.13) controlPoint1: CGPointMake(160.43, 99.34) controlPoint2: CGPointMake(159.37, 100.35)];
    [_wrkstrPath addCurveToPoint: CGPointMake(153.74, 102.83) controlPoint1: CGPointMake(156.78, 101.92) controlPoint2: CGPointMake(155.33, 102.48)];
    [_wrkstrPath addCurveToPoint: CGPointMake(149.08, 103.36) controlPoint1: CGPointMake(152.15, 103.19) controlPoint2: CGPointMake(150.59, 103.36)];
    [_wrkstrPath addCurveToPoint: CGPointMake(137.78, 100.08) controlPoint1: CGPointMake(144.17, 103.36) controlPoint2: CGPointMake(140.4, 102.27)];
    [_wrkstrPath addCurveToPoint: CGPointMake(133.85, 89.75) controlPoint1: CGPointMake(135.16, 97.89) controlPoint2: CGPointMake(133.85, 94.45)];
    [_wrkstrPath addLineToPoint: CGPointMake(132.23, 89.75)];
    [_wrkstrPath addCurveToPoint: CGPointMake(136.49, 101.26) controlPoint1: CGPointMake(132.23, 94.99) controlPoint2: CGPointMake(133.65, 98.82)];
    [_wrkstrPath addCurveToPoint: CGPointMake(149.08, 104.9) controlPoint1: CGPointMake(139.32, 103.69) controlPoint2: CGPointMake(143.52, 104.9)];
    [_wrkstrPath addCurveToPoint: CGPointMake(154.47, 104.29) controlPoint1: CGPointMake(150.86, 104.9) controlPoint2: CGPointMake(152.66, 104.7)];
    [_wrkstrPath addCurveToPoint: CGPointMake(159.33, 102.31) controlPoint1: CGPointMake(156.28, 103.89) controlPoint2: CGPointMake(157.9, 103.23)];
    [_wrkstrPath addCurveToPoint: CGPointMake(162.81, 98.74) controlPoint1: CGPointMake(160.76, 101.39) controlPoint2: CGPointMake(161.92, 100.2)];
    [_wrkstrPath addCurveToPoint: CGPointMake(164.15, 93.4) controlPoint1: CGPointMake(163.7, 97.29) controlPoint2: CGPointMake(164.15, 95.5)];
    [_wrkstrPath addCurveToPoint: CGPointMake(162.97, 88.54) controlPoint1: CGPointMake(164.15, 91.4) controlPoint2: CGPointMake(163.76, 89.78)];
    [_wrkstrPath addCurveToPoint: CGPointMake(159.89, 85.46) controlPoint1: CGPointMake(162.19, 87.3) controlPoint2: CGPointMake(161.16, 86.27)];
    [_wrkstrPath addCurveToPoint: CGPointMake(155.6, 83.56) controlPoint1: CGPointMake(158.63, 84.65) controlPoint2: CGPointMake(157.19, 84.02)];
    [_wrkstrPath addCurveToPoint: CGPointMake(150.78, 82.22) controlPoint1: CGPointMake(154.01, 83.1) controlPoint2: CGPointMake(152.4, 82.65)];
    [_wrkstrPath addCurveToPoint: CGPointMake(144.83, 80.68) controlPoint1: CGPointMake(148.51, 81.63) controlPoint2: CGPointMake(146.53, 81.11)];
    [_wrkstrPath addCurveToPoint: CGPointMake(140.09, 79.14) controlPoint1: CGPointMake(143.13, 80.25) controlPoint2: CGPointMake(141.55, 79.74)];
    [_wrkstrPath addCurveToPoint: CGPointMake(136.73, 76.59) controlPoint1: CGPointMake(138.69, 78.55) controlPoint2: CGPointMake(137.57, 77.7)];
    [_wrkstrPath addCurveToPoint: CGPointMake(135.47, 71.85) controlPoint1: CGPointMake(135.89, 75.48) controlPoint2: CGPointMake(135.47, 73.9)];
    [_wrkstrPath addCurveToPoint: CGPointMake(135.8, 69.83) controlPoint1: CGPointMake(135.47, 71.47) controlPoint2: CGPointMake(135.58, 70.8)];
    [_wrkstrPath addCurveToPoint: CGPointMake(137.34, 66.87) controlPoint1: CGPointMake(136.01, 68.85) controlPoint2: CGPointMake(136.53, 67.87)];
    [_wrkstrPath addCurveToPoint: CGPointMake(141.06, 64.2) controlPoint1: CGPointMake(138.15, 65.87) controlPoint2: CGPointMake(139.39, 64.98)];
    [_wrkstrPath addCurveToPoint: CGPointMake(147.95, 63.02) controlPoint1: CGPointMake(142.74, 63.41) controlPoint2: CGPointMake(145.03, 63.02)];
    [_wrkstrPath addCurveToPoint: CGPointMake(153.41, 63.67) controlPoint1: CGPointMake(149.95, 63.02) controlPoint2: CGPointMake(151.77, 63.24)];
    [_wrkstrPath addCurveToPoint: CGPointMake(157.67, 65.74) controlPoint1: CGPointMake(155.06, 64.1) controlPoint2: CGPointMake(156.48, 64.79)];
    [_wrkstrPath addCurveToPoint: CGPointMake(160.42, 69.34) controlPoint1: CGPointMake(158.86, 66.68) controlPoint2: CGPointMake(159.77, 67.88)];
    [_wrkstrPath addCurveToPoint: CGPointMake(161.39, 74.69) controlPoint1: CGPointMake(161.07, 70.8) controlPoint2: CGPointMake(161.39, 72.58)];
    [_wrkstrPath closePath];
    [_wrkstrPath moveToPoint: CGPointMake(176.22, 64)];
    [_wrkstrPath addLineToPoint: CGPointMake(185.61, 64)];
    [_wrkstrPath addLineToPoint: CGPointMake(185.61, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(176.22, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(176.22, 49.25)];
    [_wrkstrPath addLineToPoint: CGPointMake(174.6, 49.25)];
    [_wrkstrPath addLineToPoint: CGPointMake(174.6, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(166.98, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(166.98, 64)];
    [_wrkstrPath addLineToPoint: CGPointMake(174.6, 64)];
    [_wrkstrPath addLineToPoint: CGPointMake(174.6, 96.23)];
    [_wrkstrPath addCurveToPoint: CGPointMake(176.58, 102.35) controlPoint1: CGPointMake(174.6, 99.2) controlPoint2: CGPointMake(175.26, 101.24)];
    [_wrkstrPath addCurveToPoint: CGPointMake(181.4, 104.01) controlPoint1: CGPointMake(177.9, 103.46) controlPoint2: CGPointMake(179.51, 104.01)];
    [_wrkstrPath addCurveToPoint: CGPointMake(183.95, 103.93) controlPoint1: CGPointMake(182.64, 104.01) controlPoint2: CGPointMake(183.49, 103.98)];
    [_wrkstrPath addCurveToPoint: CGPointMake(185.37, 103.77) controlPoint1: CGPointMake(184.41, 103.87) controlPoint2: CGPointMake(184.88, 103.82)];
    [_wrkstrPath addLineToPoint: CGPointMake(185.37, 102.15)];
    [_wrkstrPath addCurveToPoint: CGPointMake(183.99, 102.35) controlPoint1: CGPointMake(185.1, 102.25) controlPoint2: CGPointMake(184.64, 102.32)];
    [_wrkstrPath addCurveToPoint: CGPointMake(181.81, 102.39) controlPoint1: CGPointMake(183.34, 102.38) controlPoint2: CGPointMake(182.62, 102.39)];
    [_wrkstrPath addCurveToPoint: CGPointMake(179.86, 102.27) controlPoint1: CGPointMake(181.16, 102.39) controlPoint2: CGPointMake(180.51, 102.35)];
    [_wrkstrPath addCurveToPoint: CGPointMake(178.08, 101.5) controlPoint1: CGPointMake(179.21, 102.19) controlPoint2: CGPointMake(178.62, 101.93)];
    [_wrkstrPath addCurveToPoint: CGPointMake(176.74, 99.55) controlPoint1: CGPointMake(177.54, 101.07) controlPoint2: CGPointMake(177.09, 100.42)];
    [_wrkstrPath addCurveToPoint: CGPointMake(176.22, 95.91) controlPoint1: CGPointMake(176.39, 98.69) controlPoint2: CGPointMake(176.22, 97.48)];
    [_wrkstrPath addLineToPoint: CGPointMake(176.22, 64)];
    [_wrkstrPath closePath];
    [_wrkstrPath moveToPoint: CGPointMake(192.9, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(192.9, 80.44)];
    [_wrkstrPath addCurveToPoint: CGPointMake(193.87, 73.8) controlPoint1: CGPointMake(192.9, 78.17) controlPoint2: CGPointMake(193.23, 75.96)];
    [_wrkstrPath addCurveToPoint: CGPointMake(196.87, 68.09) controlPoint1: CGPointMake(194.52, 71.64) controlPoint2: CGPointMake(195.52, 69.73)];
    [_wrkstrPath addCurveToPoint: CGPointMake(202.01, 64.2) controlPoint1: CGPointMake(198.22, 66.44) controlPoint2: CGPointMake(199.94, 65.14)];
    [_wrkstrPath addCurveToPoint: CGPointMake(209.43, 63.02) controlPoint1: CGPointMake(204.09, 63.25) controlPoint2: CGPointMake(206.56, 62.86)];
    [_wrkstrPath addLineToPoint: CGPointMake(209.43, 61.4)];
    [_wrkstrPath addCurveToPoint: CGPointMake(202.91, 62.21) controlPoint1: CGPointMake(206.94, 61.35) controlPoint2: CGPointMake(204.77, 61.62)];
    [_wrkstrPath addCurveToPoint: CGPointMake(198.09, 64.64) controlPoint1: CGPointMake(201.04, 62.81) controlPoint2: CGPointMake(199.44, 63.62)];
    [_wrkstrPath addCurveToPoint: CGPointMake(194.85, 68.25) controlPoint1: CGPointMake(196.74, 65.67) controlPoint2: CGPointMake(195.66, 66.87)];
    [_wrkstrPath addCurveToPoint: CGPointMake(193.06, 72.66) controlPoint1: CGPointMake(194.04, 69.62) controlPoint2: CGPointMake(193.44, 71.1)];
    [_wrkstrPath addLineToPoint: CGPointMake(192.9, 72.66)];
    [_wrkstrPath addLineToPoint: CGPointMake(192.9, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(191.28, 62.38)];
    [_wrkstrPath addLineToPoint: CGPointMake(191.28, 104.01)];
    [_wrkstrPath addLineToPoint: CGPointMake(192.9, 104.01)];
    [_wrkstrPath closePath];
    //// m Drawing
    _mPath = [UIBezierPath bezierPath];
    [_mPath moveToPoint: CGPointMake(256.39, 104.01)];
    [_mPath addLineToPoint: CGPointMake(243.75, 64)];
    [_mPath addLineToPoint: CGPointMake(243.59, 64)];
    [_mPath addLineToPoint: CGPointMake(230.79, 104.01)];
    [_mPath addLineToPoint: CGPointMake(228.28, 104.01)];
    [_mPath addLineToPoint: CGPointMake(215.4, 64)];
    [_mPath addLineToPoint: CGPointMake(215.24, 64)];
    [_mPath addLineToPoint: CGPointMake(202.85, 104.01)];
    [_mPath addLineToPoint: CGPointMake(201.31, 104.01)];
    [_mPath addLineToPoint: CGPointMake(214.19, 62.38)];
    [_mPath addLineToPoint: CGPointMake(216.46, 62.38)];
    [_mPath addLineToPoint: CGPointMake(229.5, 102.39)];
    [_mPath addLineToPoint: CGPointMake(229.66, 102.39)];
    [_mPath addLineToPoint: CGPointMake(242.62, 62.38)];
    [_mPath addLineToPoint: CGPointMake(244.72, 62.38)];
    [_mPath addLineToPoint: CGPointMake(258.01, 104.01)];
    [_mPath addLineToPoint: CGPointMake(256.39, 104.01)];
    [_mPath closePath];

    [super commonInitializer];
}

- (void)scaleByFactor:(CGFloat)scaleFactor {
    [UIView animateWithDuration: 1.0f animations:^{
        self.transform = CGAffineTransformScale(self.currentIdentityTransform, scaleFactor, scaleFactor);
    }];
    self.currentIdentityTransform = self.transform;
    
}

- (void)scaleToRect:(CGRect)rect {
    CGFloat scaleWidth = CGRectGetWidth(rect) / 280;
    CGFloat scaleHeight = CGRectGetHeight(rect) / 170;
    CGFloat scaleRight = fminf(scaleWidth, scaleHeight);
    
    self.transform = CGAffineTransformScale(self.transform, scaleRight, scaleRight);
    self.currentIdentityTransform = self.transform;
}

- (void)pulseView:(BOOL)pulse {
    [self pulseView:pulse withDelay: 0.0f];
}

-(void)pulseView:(BOOL)pulse withDelay:(CGFloat)delay {
    if (pulse) {
        CGFloat scaleFactor = 0.9;
        [UIView animateWithDuration:2 delay: delay
                            options: UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.transform = CGAffineTransformScale(self.currentIdentityTransform, scaleFactor, scaleFactor);
                         } completion: nil];
    } else {
        [UIView animateWithDuration:2.0f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.transform = self.currentIdentityTransform;
        } completion: nil];
    }
}

- (void)drawRect:(CGRect)rect {
    //// General Declarations
    NSTimeInterval excTime = [NSObject executionTime:kWSMTimeUnitMillisecond block:^{
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor *whiteColor = [UIColor colorWithRed:0 green:0 blue:0 alpha: 1];
        
        //// Shadow Declarations
        UIColor* lightShadow = [UIColor darkGrayColor];
        CGFloat lightShadowBlurRadius = 3;
        
        //// Group
        {
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, self.lightShadowOffset, lightShadowBlurRadius, lightShadow.CGColor);
            CGContextBeginTransparencyLayer(context, NULL);
            
            //// Left Circle Drawing
            [_wrkstrmGreen setFill];
            [_leftCirclePath fill];
            
            //// Right Circle Drawing
            [_wrkstrmBlue setFill];
            [_rightCirclePath fill];
            
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, self.lightShadowOffset, lightShadowBlurRadius, lightShadow.CGColor);
            [whiteColor setFill];
            [_wrkstrPath fill];
            CGContextRestoreGState(context);
            
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, self.lightShadowOffset, lightShadowBlurRadius, lightShadow.CGColor);
            [[UIColor blackColor] setFill];
            [_mPath fill];
            CGContextRestoreGState(context);
            
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
        }
    }];
    NSLog(@"Exec Time: %f", excTime);
}
@end