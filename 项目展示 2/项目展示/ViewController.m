//
//  ViewController.m
//  项目展示
//
//  Created by 郭茂 on 16/4/14.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "ViewController.h"
#import "TYCircleCell.h"
#import "TYCircleMenu.h"
#import "NewTableViewController.h"
#import "TowViewController.h"
#import "FunnyTableViewController.h"
#import "FashionTableViewController.h"
#import "GossipTableViewController.h"
#import "FunTableViewController.h"


@interface ViewController ()<TYCircleMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;


    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main.jpg"]];
    
    self.items = @[@"新闻",@"娱乐",@"开心",@"时尚",
                   @"八卦",@"fun来了",@"test_7",
                   @"test_8",@"test_9",@"test_10",@"test_11"];
    

    TYCircleMenu *menu = [[TYCircleMenu alloc]initWithRadious:240 itemOffset:0 imageArray:self.items titleArray:self.items cycle:YES menuDelegate:self];
    //    menu.isDismissWhenSelected = YES; //点击菜单项，隐藏菜单
    [self.view addSubview:menu];
    




}



- (void)selectMenuAtIndex:(NSInteger)index {
    NSLog(@"选中:%zd",index);
    NewTableViewController *newVC = [[NewTableViewController alloc]init];
    TowViewController *newVC2 = [[TowViewController alloc]init];
    FunnyTableViewController *funny = [[FunnyTableViewController alloc]init];
    FashionTableViewController *fashion = [[FashionTableViewController alloc]init];
    GossipTableViewController *gossipVC = [[GossipTableViewController alloc]init];
    FunTableViewController *funVC = [[FunTableViewController alloc]init];
    switch (index) {
        case 0:
            [self.navigationController pushViewController:newVC animated:YES];
            
            break;
        case 1:
            [self.navigationController pushViewController:newVC2 animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:funny animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:fashion animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:gossipVC animated:YES];
            break;
        case 5:
            [self.navigationController pushViewController:funVC animated:YES];
            
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
