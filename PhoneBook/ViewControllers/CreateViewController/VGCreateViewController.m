//
//  VGCreateViewController.m
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import "VGCreateViewController.h"
#import "VGPerson.h"
#import "VGTableViewController.h"

@interface VGCreateViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

@end

@implementation VGCreateViewController



- (IBAction)saveBarButton:(UIBarButtonItem *)sender {
    
    

    NSArray* fields = @[self.firstNameField, self.lastNameField, self.emailField, self.phoneNumberField];
    
    for (int i = 0; i < [fields count]; i++) {
        [[fields objectAtIndex:i] resignFirstResponder];
    }
    
    if ([self.firstNameField.text length] == 0 || [self.lastNameField.text length] == 0) {
        [self showFailureAlert];
    } else {
    [self showSuccessAlert];
        [self createPlist];
    }
    
    
}



-(void) createPlist {
    
    NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* docunentDirectory = [pathArray objectAtIndex:0];
    
    NSString* contactsPath = [docunentDirectory stringByAppendingPathComponent:@"/Contacts"];
    
    NSString* namePlist = [NSString stringWithFormat:@"%@ %@.plist",self.firstNameField.text, self.lastNameField.text];
    
    
    NSString* newDocumentDir = [contactsPath stringByAppendingPathComponent:namePlist];
    
    
    
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    [arr addObject:self.firstNameField.text];
    [arr addObject:self.lastNameField.text];
    [arr addObject:self.emailField.text];
    [arr addObject:self.phoneNumberField.text];
   
    
    [arr writeToFile:newDocumentDir atomically:YES];
  
    //
    //    NSString* str =  NSTemporaryDirectory();
    //    NSLog(@"%@",newDocumentDir);
    //
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




#pragma mark - UIAlertController

-(void) showFailureAlert {
    
    UIAlertController* failureAlertController = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Missing 1 or more empty fields" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    
    [failureAlertController addAction:alertAction];
    
    [self presentViewController:failureAlertController animated:YES completion:^{
    }];
}


-(void) showSuccessAlert {
    NSString* resultAlertStr = [NSString stringWithFormat:@"'%@ %@'\nSuccessfuly created",self.firstNameField.text, self.lastNameField.text];
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Saved!" message:resultAlertStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}





#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //NSLog(@"textField %@",textField.text);
    //NSLog(@"%@",string);
    
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
        [self.emailField becomeFirstResponder];
    } else if ([textField isEqual:self.emailField]) {
        [self.phoneNumberField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
