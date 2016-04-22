//
//  FunModel.h
//  项目展示
//
//  Created by cjp on 16/4/21.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunModel : NSObject
/** title**/
@property (nonatomic, strong) NSString *title;
/** 文本 **/
@property (nonatomic, strong) NSString *ltitle;
/** 图片 **/
@property (nonatomic, strong) NSString *thumbnail;

@property (nonatomic, strong) NSString *documentId;

@end
