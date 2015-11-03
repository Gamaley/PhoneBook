//
//  VGTableViewController.m
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import "VGTableViewController.h"
#import "VGPerson.h"
#import "VGCustomCell.h"
#import "VGDetailViewController.h"

@interface VGTableViewController ()

@property (strong,nonatomic) NSString* path;
@property (strong,nonatomic) NSMutableArray* contents;
@property (strong,nonatomic) VGPerson* person;
@property (assign,nonatomic) BOOL isBlack;
@property (assign,nonatomic) BOOL isLastNameFirst;

@end

@implementation VGTableViewController



-(id)loadPlistAtIndexPath: (NSIndexPath*) path {
    
    NSString* str = [NSString stringWithFormat:@"%@/%@",self.path, [self.contents objectAtIndex:path.row]];
    
    NSData* plistData = [NSData dataWithContentsOfFile:str];
    
    
    if (!plistData) {
        NSLog(@"ERROR");
        return nil;
    }
    
    NSError* error = nil;
    NSPropertyListFormat format;
    
    id plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
    
    if (!error) {
        NSMutableDictionary* root = plist;
        
        VGPerson* person = [[VGPerson alloc] init];
        person.firstName = [root objectForKey:@"firstName"];
        
        person.lastName = [root objectForKey:@"lastName"];
        
        
        if ([root objectForKey:@"email"]) {
           person.email = [root objectForKey:@"email"];
        }
        
        if ([root objectForKey:@"phone"]) {
            person.phoneNumber = [root objectForKey:@"phone"];
        }
        
        if ([root objectForKey:@"image"]) {
            person.image = [root objectForKey:@"image"];
        }
        
        return person;
    }
    
    
    return nil;
    
}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%ld",[self.navigationController.viewControllers count]);
    [super viewWillAppear:animated];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    self.isBlack = [[defaults valueForKey:@"black"] boolValue];
    self.isLastNameFirst = [[defaults valueForKey:@"last"] boolValue];
    
    NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSLog(@"%@",pathArray);
    
    self.path = [NSString stringWithFormat:@"%@/Contacts",[pathArray objectAtIndex:0]];
    
    NSError* error = nil;
    self.contents = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error] mutableCopy];
    
    if ([self.contents containsObject:@".DS_Store"]) {
        [self.contents removeObject:@".DS_Store"];
    }
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* Identifier = @"Cell";
    
    VGCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    
    if (!cell) {
        cell = [[VGCustomCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    
    self.person = [self loadPlistAtIndexPath:indexPath];
    
    NSString* tableLabelStrig;
    
    if (self.isLastNameFirst) {
    
    tableLabelStrig = [NSString stringWithFormat:@"%@ %@",self.person.lastName, self.person.firstName];
    } else {
    tableLabelStrig = [NSString stringWithFormat:@"%@ %@",self.person.firstName, self.person.lastName];
    }
 
    cell.nameLabel.text = tableLabelStrig;
    cell.image.image = [UIImage imageWithData:self.person.image];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VGDetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VGDetailViewController"];

    VGPerson* person = [self loadPlistAtIndexPath:indexPath];
    
    vc.firstName = person.firstName;
    vc.lastName = person.lastName;
    vc.email = person.email;
    vc.phone = person.phoneNumber;
    vc.dataImage = person.image;
    
    [self.navigationController pushViewController:vc animated:YES];
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(VGCustomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    BOOL isBlack = [[defaults objectForKey:@"black"] boolValue];
    
    if (isBlack) {
        tableView.backgroundColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor blackColor];
        cell.nameLabel.textColor = [UIColor whiteColor];
        
        
    } else {
        tableView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        cell.nameLabel.textColor = [UIColor blackColor];
        
    }
    
}


@end
