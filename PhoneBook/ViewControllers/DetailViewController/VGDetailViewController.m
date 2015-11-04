//
//  VGDetailViewController.m
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import "VGDetailViewController.h"

@interface VGDetailViewController () <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailFeeld;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonEdit;
@property (weak, nonatomic) IBOutlet UIButton *chosePhoto;
@property (weak, nonatomic) IBOutlet UIButton *takePhoto;

@property (strong,nonatomic) NSString* path;
@property (strong,nonatomic) NSString* nPath;

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
        left.tintColor = [UIColor redColor];
    [self.navigationItem setLeftBarButtonItem:left animated:NO];
    
    [self.firstNameField setEnabled:YES];
    [self.lastNameField setEnabled:YES];
    [self.emailFeeld setEnabled:YES];
    [self.phoneNumberField setEnabled:YES];
        [self.takePhoto setEnabled:YES];
        [self.chosePhoto setEnabled:YES];
        
    } else {
        if (![self.firstNameField.text  isEqual: @""] || ![self.lastNameField.text  isEqual: @""]) {
            
        [self saveToPlist];
        [self.barButtonEdit setTitle:@"Edit"];
        [self.firstNameField setEnabled:NO];
        [self.lastNameField setEnabled:NO];
        [self.emailFeeld setEnabled:NO];
        [self.phoneNumberField setEnabled:NO];
        [self.takePhoto setEnabled:NO];
        [self.chosePhoto setEnabled:NO];
        self.navigationItem.leftBarButtonItem = nil;
        }
    }
    
    
}

-(void) cancelBarButtonItem {
    self.navigationItem.leftBarButtonItem = nil;
    
    [self.barButtonEdit setTitle:@"Edit"];
    [self.firstNameField setEnabled:NO];
    [self.lastNameField setEnabled:NO];
    [self.emailFeeld setEnabled:NO];
    [self.phoneNumberField setEnabled:NO];
    [self.takePhoto setEnabled:NO];
    [self.chosePhoto setEnabled:NO];
    
    
}

#pragma mark - Plist Creation Methods

-(void) saveToPlist {
    
    NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* docunentDirectory = [pathArray objectAtIndex:0];
    
    NSString* contactsPath = [docunentDirectory stringByAppendingPathComponent:@"/Contacts"];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    
    NSString* namePlist = [NSString stringWithFormat:@"%@ %@.plist",self.firstName, self.lastName];
    NSString* newNamePlist = [NSString stringWithFormat:@"%@ %@.plist",self.firstNameField.text, self.lastNameField.text];

    self.path = [contactsPath stringByAppendingPathComponent:namePlist];
    self.nPath = [contactsPath stringByAppendingPathComponent:newNamePlist];
    
    BOOL exist = [fm fileExistsAtPath:self.path];
    
    NSError* error = nil;
    

    if (![self.path isEqualToString:self.nPath]) {
    if (exist) {
        [self newPlist];
        [fm removeItemAtPath:self.path error:&error];
        return;
    }
}
    
    [self newPlist];
    
}



-(void) newPlist {
    NSData* dataImage = UIImagePNGRepresentation(self.imageView.image);
    

    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:self.firstNameField.text forKey:@"firstName"];
    [dict setObject:self.lastNameField.text forKey:@"lastName"];
    [dict setObject:self.emailFeeld.text forKey:@"email"];
    [dict setObject:self.phoneNumberField.text forKey:@"phone"];
    [dict setObject:dataImage forKey:@"image"];
    
    if (![dict objectForKey:@"phone"]) {
        [dict setObject:self.phone forKey:@"phone"];
    }
    
    [dict writeToFile:self.nPath atomically:YES];
    
}

#pragma mark - Avatar

-(IBAction)takeAPhoto:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

-(IBAction)choosePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma mark - UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString* resultStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSCharacterSet* decimals = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray* components = [string componentsSeparatedByCharactersInSet:decimals];
    
    if ([textField isEqual:self.phoneNumberField]) {
        
        if ([resultStr length] > 12) {
            return NO;
        }
        
        if ([components count] > 1) {
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.firstNameField]) {
        [self.lastNameField becomeFirstResponder];
    } else if ([textField isEqual:self.lastNameField]) {
        [self.emailFeeld becomeFirstResponder];
    } else if ([textField isEqual:self.emailFeeld]) {
        [self.phoneNumberField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
   return YES;
    
}

@end
