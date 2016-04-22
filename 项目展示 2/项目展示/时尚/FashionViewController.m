//
//  FashionViewController.m
//  项目展示
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "FashionViewController.h"
#import "NetWorkRequestManager.h"
#import "FashionTableViewController.h"
#import "NSString+Html.h"
@interface FashionViewController ()

@end

@implementation FashionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.scalesPageToFit = YES;

    [self.view addSubview:self.webView];

    NSURL *url = [NSURL URLWithString:self.ssss];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];

        
        NSString *string =dic[@"body"][@"text"];

        
        
        NSString *newString = [NSString importStyleWithHtmlString:string];
        //baseURL可以让界面加载的时候按照本地样式去加载
        NSURL *baseURL = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
        [_webView loadHTMLString:newString baseURL:baseURL];
        
    } ];
    
    [task resume];
//    NSLog(@"------%@",self.ssss);
    
    
    
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
