//
//  IntroViewController.m
//  TicTacToe
//
//  Created by Ehsan Jahromi on 10/5/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIButton *onePlayerButton;

@end

@implementation IntroViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    

    self.firstLabel.alpha = 1.0;
    self.secondLabel.alpha = 1.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navBarCustomization];
}

-(void)navBarCustomization{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
}

- (IBAction)onePlayerGameStart:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.firstLabel.frame = CGRectMake(-200, self.firstLabel.frame.origin.y, self.firstLabel.frame.size.width, self.firstLabel.frame.size.height);
                         self.secondLabel.frame = CGRectMake(400, self.secondLabel.frame.origin.y, self.secondLabel.frame.size.width, self.secondLabel.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         self.firstLabel.alpha = 0.0;
                         self.secondLabel.alpha = 0.0;
                         [self performSegueWithIdentifier:@"StartGame" sender:nil];
                     }];
    
}


@end
