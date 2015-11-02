//
//  VGCustomCell.h
//  PhoneBook
//
//  Created by Vladyslav on 28.10.15.
//  Copyright © 2015 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VGCustomCell : UITableViewCell

@property(weak,nonatomic) IBOutlet UILabel* nameLabel;
@property(weak,nonatomic) IBOutlet UIImageView* image;

@end
