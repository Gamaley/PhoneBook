//
//  VGTableViewController.h
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VGPerson;

@interface VGTableViewController : UITableViewController

@property (strong,nonatomic) VGPerson* person;
@property (strong,nonatomic) NSMutableArray* cells;


//- (id)initWithFolderPath:(NSString*) path;

@end
