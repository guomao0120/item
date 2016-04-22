//
//  FunTableViewController.m
//  项目展示
//
//  Created by cjp on 16/4/21.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "FunTableViewController.h"
#import "FunModel.h"
#import "FunTableViewCell.h"
#import "FunInfoViewController.h"
#import "UIImageView+WebCache.h"
@interface FunTableViewController ()

@property (nonatomic,strong)NSMutableArray *arrayData;
@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation FunTableViewController
-(NSMutableArray *)arrayData{
    if (_arrayData ==nil) {
        _arrayData =[NSMutableArray array];
    }
    return _arrayData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    [self setUpData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FunTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
}
- (void)setUpData{
    self.array = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:@"http://api.iclient.ifeng.com/ClientNews?id=DZPD,FOCUSDZPD&gv=5.1.1&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=640x1136&publishid=4002&uid=454db92936f54288b38b5af04f18ee16"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *dic = array[0];
        NSArray *arr = [dic objectForKey:@"item"];
        
        for (NSDictionary *diccc in arr) {
            FunModel *model =[[FunModel alloc] init];
            
            [model setValuesForKeysWithDictionary:diccc];
            NSLog(@"----%@",model.title);
            
            [self.arrayData addObject:model];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }];
    [task resume];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"==%ld",self.arrayData.count);
    return self.arrayData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    FunModel *model =self.arrayData[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    cell.funLabel.text =model.title;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FunInfoViewController *infnVC =[[FunInfoViewController alloc] init];
    FunModel *modle =self.arrayData[indexPath.row];
    infnVC.model = modle;
    
    [self.navigationController pushViewController:infnVC animated:YES];
}
@end
