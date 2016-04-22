//
//  FunInfoViewController.m
//  项目展示
//
//  Created by cjp on 16/4/21.
//  Copyright © 2016年 郭茂. All rights reserved.
//

#import "FunInfoViewController.h"
#import "NSString+Html.h"
@interface FunInfoViewController ()
@property(nonatomic,strong) NSMutableArray *arrayData;
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) UIWebView *contentWebView;

@end

@implementation FunInfoViewController
- (void)setUpData{
    self.contentWebView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
    [self.view addSubview:self.contentWebView];
    self.array = [NSMutableArray array];
    NSString *string =[NSString stringWithFormat:@"http://api.iclient.ifeng.com/ipadtestdoc?aid= %@&gv=5.1.1&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=640x1136&publishid=4002&uid=454db92936f54288b38b5af04f18ee16",_model.documentId];
    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSString *string =dic[@"body"][@"text"];
        NSLog(@"--%@",string);
        NSString *newString = [NSString importStyleWithHtmlString:string];
        //baseURL可以让界面加载的时候按照本地样式去加载
        NSURL *baseURL = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
        [_contentWebView loadHTMLString:newString baseURL:baseURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
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
