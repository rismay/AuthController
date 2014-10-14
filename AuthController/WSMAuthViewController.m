//
//  WSMLoginViewController.m
//  rendezvous
//
//  Created by Cristian Monterroza on 7/23/14.
//
//

#import "WSMAuthViewController.h"
#import "WSMEditableTableViewCell.h"
#import "AppDelegate.h"
#import "WSMVectorLogoView.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface WSMAuthViewController () <UITextFieldDelegate,
UITableViewDelegate, UITableViewDelegate, UITableViewDataSource>

#pragma mark - Controller State.
@property (nonatomic) WSMAuthTableViewType controllerType;
@property (nonatomic) BOOL tableViewOffset;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;

#pragma mark - TableView Instance Variables

@property (nonatomic) NSInteger numberOfSections;
@property (nonatomic) NSInteger numberOfRows;
@property (nonatomic, strong) NSString *titleForHeader;

@end

@implementation WSMAuthViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    
    RAC(self, title) = [RACObserve(self, controllerType) map:^NSString *(NSNumber *controllerType){
        switch ([controllerType intValue]) {
            case kWSMAuthTableViewTypeSignUp: return @"Sign Up";
            case kWSMAuthTableViewTypeSignIn: return @"Sign In";
            default: return @"Welcome";
        }
    }];
    
    return self;
}

#pragma mark - View Lifecycle

#define authenticatedSegue @"authenticatedSegue"
#define permissionCell @"permissionCell"
#define editableCell @"WSMEditableTableViewCell"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.delegate respondsToSelector:@selector(authenticated)] &&
        [self.delegate authenticated]) {
        [self performSegueWithIdentifier:authenticatedSegue sender:self];
    } else {
        [self.tableView registerNib:[UINib nibWithNibName:@"WSMTableViewCell" bundle:nil]
             forCellReuseIdentifier:permissionCell];
        [self.tableView registerNib:[UINib nibWithNibName:@"WSMEditableTableViewCell" bundle:nil]
             forCellReuseIdentifier:editableCell];
        
        [self configureActions];
        [self configureTableViewReload];
        [self configureTableViewAnimations];
        [self configureKeyboardAnimations];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - State Configuration

- (void) configureActions {
    @weakify(self);
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id element) {
        @strongify(self);
        if ([element isEqual:self.signInButton]) {
            self.controllerType = kWSMAuthTableViewTypeSignIn;
        } else if ([element isEqual:self.signUpButton]) {
            self.controllerType = kWSMAuthTableViewTypeSignUp;
        } else {
            self.controllerType = kWSMAuthTableViewTypeUnknown;
        }
        return [RACSignal empty];
    }];
    
    self.signInButton.rac_command = command;
    self.signUpButton.rac_command = command;
    self.cancelButton.rac_command = command;
    
    if ([self.delegate respondsToSelector:@selector(styleAuthButtons)]) {
        [self.delegate styleAuthButtons];
    } else {
        self.signInButton.backgroundColor = [UIColor grayColor];
        self.signUpButton.backgroundColor = [UIColor darkGrayColor];
    }
}

- (void)configureTableViewAnimations {
    @weakify(self);
    [RACObserve(self, controllerType) subscribeNext:^(NSNumber *controllerType) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat duration = 0.9, damping = 0.8;
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping
                  initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^
             {
                 switch ([controllerType intValue]) {
                     case kWSMAuthTableViewTypeSignIn:
                     case kWSMAuthTableViewTypeSignUp: {
                         self.tableView.frame = CGRectOffset(self.tableView.frame, 0,
                                                             -CGRectGetHeight(self.tableView.frame));
                         self.signInButton.alpha = self.signUpButton.alpha = 0.0f;
                         self.cancelButton.enabled = YES;
                         self.cancelButton.title = @"Cancel";
                     } break;
                     case kWSMAuthTableViewTypeUnknown: {
                         self.tableView.frame = CGRectOffset(self.tableView.frame, 0,
                                                             CGRectGetHeight(self.tableView.frame));
                         self.signInButton.alpha = self.signUpButton.alpha = 1.0f;
                         self.cancelButton.enabled = NO;
                         self.cancelButton.title = @"";
                     } break;
                 }
             } completion:^(BOOL finished) {}];
        });
    }];
}

- (void)configureTableViewReload {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    @weakify(self);
    [RACObserve(self, controllerType) subscribeNext:^(NSNumber *controllerType) {
        @strongify(self);
        switch ([controllerType intValue]) {
            case kWSMAuthTableViewTypeSignIn: {
                self.numberOfSections = 1;
                self.numberOfRows = 2;
                self.titleForHeader = @"Sign In";
            } break;
            case kWSMAuthTableViewTypeSignUp: {
                self.numberOfSections = 1;
                self.numberOfRows = 3;
                self.titleForHeader = @"Sign Up";
            } break;
            default:{
                self.numberOfSections = 0;
                self.numberOfRows = 0;
            } break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)configureKeyboardAnimations {
    CGFloat duration = 0.9, damping = 0.8;
    @weakify(self);
    [[[NSNotificationCenter.defaultCenter rac_addObserverForName:UIKeyboardWillShowNotification
                                                          object:nil]
      takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification *notification) {
        @strongify(self);
        if (!self.tableViewOffset) {
            CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping
                  initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent
                             animations:^{
                                 self.tableView.frame = CGRectOffset(self.tableView.frame, 0,
                                                                     -CGRectGetHeight(keyboardRect));
                             } completion:^(BOOL finished) {}];
            self.tableViewOffset = YES;
        }
    }];
    
    [[[NSNotificationCenter.defaultCenter rac_addObserverForName:UIKeyboardWillHideNotification
                                                          object:nil]
      takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification *notification) {
        @strongify(self);
        CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping
              initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             self.tableView.frame = CGRectOffset(self.tableView.frame, 0,
                                                                 CGRectGetHeight(keyboardRect));
                         } completion:^(BOOL finished) {}];
        self.tableViewOffset = NO;
    }];
}

#pragma mark - Table View DataSource and Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titleForHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSMEditableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:editableCell
                                                                     forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    
    switch (indexPath.row) {
        case 0: {
            [cell prepareForUsername:self];
        } break;
        default: {
            [cell prepareForPassword:self];
        }break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WSMEditableTableViewCell *nextCell = (WSMEditableTableViewCell *)[self.tableView
                                                                      cellForRowAtIndexPath:indexPath];
    [nextCell.detailTextField becomeFirstResponder];
}

#pragma mark - TextField Delegate

#define usernameTag 0
#define passwordTag 1


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    switch (textField.tag) {
        case usernameTag:{
            WSMEditableTableViewCell *nextCell = (WSMEditableTableViewCell *)[self.tableView
                                                                              cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1
                                                                                                                       inSection:0]];
            [nextCell.detailTextField becomeFirstResponder];
            return YES;
        } break;
        case passwordTag: {
            if (self.controllerType == kWSMAuthTableViewTypeSignUp) {
                WSMEditableTableViewCell *nextCell = (WSMEditableTableViewCell *)[self.tableView
                                                                                  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2
                                                                                                                           inSection:0]];
                [nextCell.detailTextField becomeFirstResponder];
            } else {
                WSMEditableTableViewCell *usernameCell = (WSMEditableTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                WSMEditableTableViewCell *passwordCell = (WSMEditableTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                if (![usernameCell.detailTextField.text isEqualToString:@""] &&
                    ![passwordCell.detailTextField.text isEqualToString:@""]) {
                    [textField endEditing:YES];
                    NSString *trimmedUsername = [usernameCell.detailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSString *password = passwordCell.detailTextField.text;
                    if ([self.delegate respondsToSelector:@selector(authenticateWithUsername:password:)]) {
                        [self.delegate authenticateWithUsername:trimmedUsername password:password];
                    }
                    return YES;
                } else {
                    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                                message:@"It takes two to make this work."
                                               delegate:nil
                                      cancelButtonTitle:@"Okay."
                                      otherButtonTitles:nil] show];
                }
            }
        } break;
        default:{
            WSMEditableTableViewCell *usernameCell = (WSMEditableTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            WSMEditableTableViewCell *passwordCell = (WSMEditableTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            WSMEditableTableViewCell *confirmCell = (WSMEditableTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            BOOL passwordMatch = [passwordCell.detailTextField.text isEqualToString:@""] &&
            [passwordCell.detailTextField.text isEqualToString:confirmCell.detailTextField.text];
            if (![usernameCell.detailTextField.text isEqualToString:@""] && passwordMatch) {
                [textField endEditing:YES];
                NSString *trimmedUsername = [usernameCell.detailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                NSString *password = passwordCell.detailTextField.text;
                if ([self.delegate respondsToSelector:@selector(authenticateWithUsername:password:)]) {
                    [self.delegate authenticateWithUsername:trimmedUsername password:password];
                }
                return YES;
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Passwords Do Not Match"
                                            message:@"You already forgot your password?"
                                           delegate:nil
                                  cancelButtonTitle:@"No bueno."
                                  otherButtonTitles:nil] show];
                return NO;
            }
        }break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

#pragma mark - Navigation

- (void)authenticated {
    [self performSegueWithIdentifier:authenticatedSegue sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:authenticatedSegue]) {
        UIViewController *controller = segue.destinationViewController;
        controller.navigationItem.hidesBackButton = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
