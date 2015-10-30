//
//  VGCancelSegue.m
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import "VGCancelSegue.h"

@implementation VGCancelSegue

-(void) perform {
    UITableViewController* source = (UITableViewController*)self.sourceViewController;
    [source.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [source viewDidLoad];
}

@end
