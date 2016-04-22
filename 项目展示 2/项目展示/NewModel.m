//
//  NewModel.m
//  项目展示
//
//  Created by 郭茂 on 16/4/14.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "NewModel.h"

@implementation NewModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"post"]) {
        self.title = value[@"title"];
        self.ID = value[@"id"];
        
    }
    
}



@end
