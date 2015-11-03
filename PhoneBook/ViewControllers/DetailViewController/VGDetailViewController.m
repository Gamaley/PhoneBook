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


-(IBAction)editAction:(UIBarButtonItem*)sender {
   
    [self.firstNameField setEnabled:YES];
    [self.lastNameField setEnabled:YES];
    [self.emailFeeld setEnabled:YES];
    [self.phoneNumberField setEnabled:YES];
    
}

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


@end
