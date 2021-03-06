//
//  CFSAuthViewController.m
//  CloudFS
//
//  Created by xes on 10/13/14.
//  Copyright (c) 2014 wrkstrm. All rights reserved.
//

#import "SAMAuthViewController.h"
#import "WSMVectorLogoView.h"
#import "AppDelegate.h"
#import <WSMUtilities/WSMColorPalette.h>

@interface SAMAuthViewController () <WSMLoginViewDelegate>

@property (nonatomic, strong) IBOutlet WSMVectorLogoView *smallVectorLogo;

@end

@implementation SAMAuthViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    self.delegate = self;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.smallVectorLogo.enabled = YES;
    [self.smallVectorLogo pulseView:YES];
}

- (void)authController:(WSMAuthViewController*)authController
           styleSignIn:(UIButton *)signIn
                signUp:(UIButton *)signUp {
    signIn.layer.cornerRadius = 5.0;
    signIn.backgroundColor = [WSMColorPalette colorGradient:kWSMGradientGreen
                                                              forIndex:0
                                                               ofCount:0
                                                              reversed:NO];
    
    signUp.layer.cornerRadius = 5.0;
    signUp.backgroundColor = [WSMColorPalette colorGradient:kWSMGradientBlue
                                                              forIndex:0
                                                               ofCount:0
                                                              reversed:NO];
}

- (void)authController:(WSMAuthViewController*)authController
  authenticateUsername:(NSString *)username
              password:(NSString *)password {
    [[[UIAlertView alloc] initWithTitle:@"Correct Password"
                                message:@"BTW: This will always works"
                               delegate:nil
                      cancelButtonTitle:@"Try again?"
                      otherButtonTitles:nil] show];
}

- (BOOL)authenticated {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
