//
//  VGDetailViewController.h
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VGDetailViewController : UIViewController

@property(strong,nonatomic) NSString* firstName;
@property(strong,nonatomic) NSString* lastName;
@property(strong,nonatomic) NSString* email;
@property(strong,nonatomic) NSString* phone;

@end
