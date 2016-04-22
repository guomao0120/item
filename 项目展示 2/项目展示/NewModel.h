//
//  NewModel.h
//  项目展示
//
//  Created by 郭茂 on 16/4/14.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewModel : NSObject

/** title**/
@property (nonatomic, strong) NSString *title;
/** 文本 **/
@property (nonatomic, strong) NSString *ltitle;
/** 图片 **/
@property (nonatomic, strong) NSString *imgsrc;

/**  **/
@property (nonatomic, strong) NSString *digest;

/** title **/
@property (nonatomic, strong) NSString *url;
/**  **/
@property (nonatomic, assign) NSInteger priority;

@property(nonatomic,strong)NSString * img;

@property(nonatomic,strong) NSString *ID;

@property(nonatomic,strong)NSString * image;






@end
