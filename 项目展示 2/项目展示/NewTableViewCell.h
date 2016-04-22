//
//  NewTableViewCell.h
//  项目展示
//
//  Created by 郭茂 on 16/4/14.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
