//
//  FashionTableViewController.m
//  项目展示
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "FashionTableViewController.h"
#import "FashionTableViewCell.h"
#import "FashionModel.h"
#import <UIImageView+WebCache.h>
#import "FashionViewController.h"

@interface FashionTableViewController ()

@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation FashionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册
    [self.tableView registerClass:[FashionTableViewCell class] forCellReuseIdentifier:@"CELL"];
    self.navigationController.navigationBarHidden = NO;
    
    [self setupData];
    
}

-(void)setupData{
    self.array = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:@"http://api.iclient.ifeng.com/ClientNews?id=SS78,FOCUSSS78&gv=5.1.1&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=640x1136&publishid=4002&uid=454db92936f54288b38b5af04f18ee16"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       
        NSArray *arrrrrr = arr[0][@"item"];

        for (NSDictionary *dic in arrrrrr) {
            FashionModel *model =[[FashionModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if (model.thumbnail.length ==0||model.updateTime.length==0 ) {
                
            }else{
            [self.array addObject:model];
            }}
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",_array.count);
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FashionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    FashionModel *model =self.array[indexPath.row];
    
    cell.label.text = model.title;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"1"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
    

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FashionModel *model = self.array[indexPath.row];
    
    FashionViewController *vc = [[FashionViewController alloc]init];
    vc.ssss=model.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
