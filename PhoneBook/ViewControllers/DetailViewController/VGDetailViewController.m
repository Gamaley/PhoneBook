//
//  VGDetailViewController.m
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import "VGDetailViewController.h"

@interface VGDetailViewController ()

@end

@implementation VGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%ld",[self.navigationController.viewControllers count]);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
