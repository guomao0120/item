//
//  FunnyTableViewCell.m
//  
//
//  Created by lanou3g on 16/4/21.
//
//

#import "FunnyTableViewCell.h"

@implementation FunnyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, self.frame.size.width, 160)];
        self.label.numberOfLines =0;
        self.image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"开心背景图.png"]];
     [self.contentView addSubview:self.image];
        
        
       [self.image addSubview:self.label];
        
    }

    
    return self;
}

@end
