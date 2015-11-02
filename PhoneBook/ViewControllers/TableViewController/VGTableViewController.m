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

@property(strong,nonatomic) NSString* path;
@property (strong,nonatomic) NSMutableArray* contents;

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
        NSMutableArray* root = plist;
       // NSLog(@"%@",root);
        return root;
    }
    
    return nil;
    
}


- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%ld",[self.navigationController.viewControllers count]);
    [super viewWillAppear:animated];
    
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
    
    NSMutableArray* arr = [self loadPlistAtIndexPath:indexPath];
    
    
    NSString* nameFieldString = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
    
    cell.nameLabel.text = nameFieldString;
    //cell.imageView.image =
    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VGDetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VGDetailViewController"];
    
    NSMutableArray* arr = [self loadPlistAtIndexPath:indexPath];
    NSLog(@"%li",[arr count]);
    vc.firstName = [arr objectAtIndex:0];
    vc.lastName = [arr objectAtIndex:1];
    
    if ([arr count] == 3 ) {
        vc.email = [arr objectAtIndex:2];
    }
    if ([arr count] == 4) {
        vc.email = [arr objectAtIndex:2];
        vc.phone = [arr objectAtIndex:3];
    }
    if ([arr count] == 5) {
        vc.email = [arr objectAtIndex:2];
        vc.phone = [arr objectAtIndex:3];
        vc.dataImage = [arr objectAtIndex:4];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
