//
//  VGDetailViewController.m
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import "VGDetailViewController.h"

@interface VGDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailFeeld;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonEdit;

@end

@implementation VGDetailViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%ld",[self.navigationController.viewControllers count]);
    
    self.firstNameField.text = self.firstName;
    self.lastNameField.text = self.lastName;
    self.emailFeeld.text = self.email;
    self.phoneNumberField.text = self.phone;
    self.imageView.image = [UIImage imageWithData:self.dataImage];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UIBarButtonItem

-(IBAction)editAction:(UIBarButtonItem*)sender {
    
    if (![self.firstNameField isEnabled]) {
        
    [sender setTitle:@"Save"];
    
    UIBarButtonItem* left = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBarButtonItem)];
    [self.navigationItem setLeftBarButtonItem:left animated:NO];
    
    
    [self.firstNameField setEnabled:YES];
    [self.lastNameField setEnabled:YES];
    [self.emailFeeld setEnabled:YES];
    [self.phoneNumberField setEnabled:YES];
        
    } else {
        [self saveToPlist];
    }
    
    
}

-(void) cancelBarButtonItem {
    self.navigationItem.leftBarButtonItem = nil;
    
    [self.barButtonEdit setTitle:@"Edit"];
    [self.firstNameField setEnabled:NO];
    [self.lastNameField setEnabled:NO];
    [self.emailFeeld setEnabled:NO];
    [self.phoneNumberField setEnabled:NO];
}


-(void) saveToPlist {
    
    
}

@end
