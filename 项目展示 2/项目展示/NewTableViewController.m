//
//  NewTableViewController.m
//  项目展示
//
//  Created by 郭茂 on 16/4/14.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "NewTableViewController.h"
#import "NetWorkRequestManager.h"
#import "NewTableViewCell.h"
#import "NewModel.h"
#import "UIImageView+WebCache.h"
#import "NewViewController.h"
@interface NewTableViewController ()

@property (nonatomic, strong)NSMutableArray *arrayData;
/** 数组 **/
@property (nonatomic, strong) NSMutableArray *array;


@end

@implementation NewTableViewController

static NSString *ident = @"New";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewTableViewCell class]) bundle:nil] forCellReuseIdentifier:ident];
    
    self.navigationController.navigationBarHidden = NO;

//    self.view.backgroundColor = [UIColor redColor];
    [self setUpData];
    
   
    
    
    
}

- (void)setUpData{
    self.arrayData = [NSMutableArray array];
    self.array = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/nc/article/list/T1414142214384/0-20.html"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [dic writeToFile:@"/Users/guomo/Desktop/re.plist" atomically:YES];
        NSLog(@"%@",dic);
//        NSLog(@"%@",arr);
        self.arrayData = dic[@"T1414142214384"];
        for (NSDictionary *dict in self.arrayData) {
            NewModel *model = [[NewModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.array addObject:model];
        }
        
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    NewModel *model = self.array[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.contentLabel.text = model.digest;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"1"]];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewModel *model = self.array[indexPath.row];
    NewViewController *newVC = [[NewViewController alloc]init];
    newVC.stringVc = model.url;
    [self.navigationController pushViewController:newVC animated:YES];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
