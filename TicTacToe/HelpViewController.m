//
//  HelpViewController.m
//  TicTacToe
//
//  Created by Ehsan on 10/4/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    
    NSURL *url = [NSURL URLWithString:@"https://en.wikipedia.org/wiki/Tic-tac-toe"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.webView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebView Delegates
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner stopAnimating];
}



- (IBAction)showGame:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
