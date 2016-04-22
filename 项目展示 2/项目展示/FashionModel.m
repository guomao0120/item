//
//  FashionModel.m
//  项目展示
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "FashionModel.h"

@implementation FashionModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
    
@end
