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

@end

@implementation VGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%ld",[self.navigationController.viewControllers count]);
    
    self.firstNameField.text = self.firstName;
    self.lastNameField.text = self.lastName;
    self.emailFeeld.text = self.email;
    self.phoneNumberField.text = self.phone;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
