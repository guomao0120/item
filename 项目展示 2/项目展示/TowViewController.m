//
//  TowViewController.m
//  项目展示
//
//  Created by cjp on 16/4/18.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "TowViewController.h"
#import "UIImageView+WebCache.h"
#import "NewModel.h"
#import "TowTableViewCell.h"
#import "InfoViewController.h"
@interface TowViewController ()
@property(nonatomic,strong) NSMutableArray *arrayData;

@property(nonatomic,strong) NSMutableArray *array;

@end

@implementation TowViewController

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

    [self.tableView registerNib:[UINib nibWithNibName:@"TowTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
}


- (void)setUpData{
//    self.arrayData = [NSMutableArray array];
    self.array = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:@"http://app3.qdaily.com/app3/homes/index/0.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
          NSDictionary *dic2 = [dic objectForKey:@"response"];
        NSArray *arr =dic2[@"feeds"];
        
        for (NSDictionary *diccc in arr) {
            NewModel *model =[[NewModel alloc] init];
            NSLog(@"----%@",diccc);
            
            [model setValuesForKeysWithDictionary:diccc];

            if (model.image ==nil) {
                
            }else{
            [self.arrayData addObject:model];
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }];
    [task resume];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",self.arrayData.count);
    return self.arrayData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    NewModel *model =self.arrayData[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"1"]];
    cell.nameLabel.text =model.title;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InfoViewController *infnVC =[[InfoViewController alloc] init];
    NewModel *modle =self.arrayData[indexPath.row];
    infnVC.model =modle;
    [self.navigationController pushViewController:infnVC animated:YES];
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
