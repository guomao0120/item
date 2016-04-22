//
//  ViewController.h
//  项目展示
//
//  Created by 郭茂 on 16/4/14.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYCircleCollectionView.h"


@interface ViewController : UIViewController
@property (nonatomic, strong) TYCircleCollectionView *collectionView;

@property (nonatomic, copy) NSArray *items;

@end

