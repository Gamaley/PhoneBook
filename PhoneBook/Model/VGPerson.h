//
//  VGPerson.h
//  PhoneBook
//
//  Created by Vladyslav on 29.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGPerson : NSObject

@property (strong,nonatomic) NSString* firstName;
@property (strong,nonatomic) NSString* lastName;
@property (strong,nonatomic) NSString* email;
@property (strong,nonatomic) NSString* phoneNumber;
@property (strong,nonatomic) NSData* image;

@end
