//
//  VGSettingsViewController.m
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import "VGSettingsViewController.h"

@interface VGSettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *blakInterfaceSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *isLastNameFirst;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;


@end


@implementation VGSettingsViewController

#pragma mark - Actions

- (IBAction)actionSegmentControl:(UISegmentedControl *)sender {
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if ([self.isLastNameFirst selectedSegmentIndex] == 1) {
        [defaults setObject:@1 forKey:@"last"];
        [self.isLastNameFirst setSelectedSegmentIndex:1];
        [defaults synchronize];
    } else {
        [defaults setObject:@0 forKey:@"last"];
        [self.isLastNameFirst setSelectedSegmentIndex:0];
        [defaults synchronize];
    }
    
    
}


- (IBAction)switchInterface:(UISwitch *)sender {
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%i",self.blakInterfaceSwitch.on);
    
    
    if (self.blakInterfaceSwitch.on) {
        [defaults setObject:@1 forKey:@"black"];
        self.view.backgroundColor = [UIColor blackColor];
        self.switchLabel.textColor = [UIColor whiteColor];
        [self.blakInterfaceSwitch setOn:YES];
    } else {
        [defaults setObject:@0 forKey:@"black"];
        self.view.backgroundColor = [UIColor whiteColor];
        self.switchLabel.textColor = [UIColor blackColor];
        [self.blakInterfaceSwitch setOn:NO];
    }
    
}


#pragma mark - Helper Methods

-(BOOL) checkIfRowExist {
    
    NSFileManager* fm = [NSFileManager defaultManager];
    NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docunentDirectory = [pathArray objectAtIndex:0];
    NSString* contactsPath = [docunentDirectory stringByAppendingPathComponent:@"/Contacts"];
    
    NSError* error = nil;
    NSArray* contentsContacts = [fm contentsOfDirectoryAtPath:contactsPath error:&error];
    
    BOOL isExist = YES;
    
    if ([contentsContacts count] == 0) {
        isExist = NO;
    }
    
    return isExist;
}

#pragma mark - UIViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    BOOL isBlack = [[defaults objectForKey:@"black"] boolValue];
    BOOL isLast = [[defaults objectForKey:@"last"] boolValue];
    
    if (![self checkIfRowExist]) {
        [self.isLastNameFirst setEnabled:NO];
        [self.switchLabel setEnabled:NO];
    } else {
        
        [self.isLastNameFirst setEnabled:YES];
        [self.switchLabel setEnabled:YES];
    }
    
    
    if (isBlack) {
        [self.blakInterfaceSwitch setOn:YES];
        self.view.backgroundColor = [UIColor blackColor];
        self.switchLabel.textColor = [UIColor whiteColor];
    } else {
        [self.blakInterfaceSwitch setOn:NO];
        self.view.backgroundColor = [UIColor whiteColor];
        self.switchLabel.textColor = [UIColor blackColor];
    }
    
    if (isLast) {
        [self.isLastNameFirst setSelectedSegmentIndex:1];
    } else {
        [self.isLastNameFirst setSelectedSegmentIndex:0];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
