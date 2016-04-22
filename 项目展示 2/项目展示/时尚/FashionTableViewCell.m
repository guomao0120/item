//
//  FashionTableViewCell.m
//  项目展示
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "FashionTableViewCell.h"

@implementation FashionTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.img =[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 120, 120)];
        [self.contentView addSubview:self.img];
        self.label =[[UILabel alloc] initWithFrame:CGRectMake(150, 20, 200, 60)];
        self.label.numberOfLines = 0;
        self.label.font =[UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.label];
    }
    return self;
}
@end
