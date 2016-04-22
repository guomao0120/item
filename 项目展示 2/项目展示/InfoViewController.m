//
//  InfoViewController.m
//  项目展示
//
//  Created by cjp on 16/4/21.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()
@property(nonatomic,strong) NSMutableArray *arrayData;
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSString *string;
@property(nonatomic,strong) UIWebView *webView;
@end

@implementation InfoViewController
- (void)setUpData{
    self.webView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:self.webView];
        self.arrayData = [NSMutableArray array];
    self.array = [NSMutableArray array];
    NSString *sstring =[NSString stringWithFormat:@"http://app3.qdaily.com/app3/articles/info/%@.json",_model.ID];
    NSURL *url = [NSURL URLWithString:sstring];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",_model.ID);
        NSDictionary *dic2 = [dic objectForKey:@"response"];
        
       self.string =dic2[@"post"][@"appview"];
        NSLog(@"%@",self.string);
        _webView.scalesPageToFit = NO;
        NSURL *url = [[NSURL alloc]initWithString:self.string];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        [self.view addSubview:_webView];
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.webView reloadInputViews];
        });

        
        
    }];
    [task resume];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    [self setUpData];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
