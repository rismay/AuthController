//
//  WSMLoginViewController.h
//  rendezvous
//
//  Created by Cristian Monterroza on 7/23/14.
//
//

#import "AppDelegate.h"


typedef NS_ENUM(NSUInteger, WSMAuthTableViewType) {
    kWSMAuthTableViewTypeUnknown,
    kWSMAuthTableViewTypeSignUp,
    kWSMAuthTableViewTypeSignIn
};

@protocol WSMLoginViewDelegate <NSObject, UITextFieldDelegate>

@required

- (void)authenticateWithUsername:(NSString *)username password:(NSString *)password;

- (void)styleAuthButtons;

- (BOOL)authenticated;

@end

@interface WSMAuthViewController : UIViewController

@property (nonatomic, strong, readwrite) IBOutlet UIButton *signInButton;
@property (nonatomic, strong, readwrite) IBOutlet UIButton *signUpButton;

@property (nonatomic, weak) id<WSMLoginViewDelegate> delegate;

- (void)authenticated;

@end
