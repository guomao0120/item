//
//  FunnyTableViewController.m
//  项目展示
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "FunnyTableViewController.h"
#import "FunnyTableViewCell.h"
#import "FunnyModel.h"
#import <UIImageView+WebCache.h>
#import "NetWorkRequestManager.h"

@interface FunnyTableViewController ()


/**
 *数组
 */
@property(nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation FunnyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册
    [self.tableView registerClass:[FunnyTableViewCell class] forCellReuseIdentifier:@"CELL"];
    self.navigationController.navigationBarHidden = NO;

    
    [self setupData];
    
    
    
}

-(void)setupData{
    self.dataArray = [NSMutableArray array];
     NSURL *url = [NSURL URLWithString:@"http://m2.qiushibaike.com/article/list/text?count=30&readarticles=%5B116054125%2C116053727%2C116054449%2C116051204%2C116058681%2C116058394%5D&page=1&AdID=146120790340568C4460F9"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       
        NSArray *arr = dic[@"items"];
        
        
        for (NSDictionary *dict in arr) {
            FunnyModel *model = [[FunnyModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
           
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [task resume];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FunnyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    FunnyModel *model = self.dataArray[indexPath.row];
    NSLog(@"%@",model.content);
    
    cell.label.frame=CGRectMake(10, 5, self.view.frame.size.width-20, [self text:model.content]);
    cell.image.frame =CGRectMake(0, 0, self.view.frame.size.width,CGRectGetMaxY(cell.label.frame)+10);
    cell.label.text = model.content;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FunnyModel *model = self.dataArray[indexPath.row];
    return [self text:model.content] + 20;
}

-(CGFloat)text:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(280, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height;
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
