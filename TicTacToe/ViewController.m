//
//  ViewController.m
//  TicTacToe
//
//  Created by Ehsan on 10/1/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UILabel *labelNine;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property (strong,nonatomic) NSArray *labelArray;
@end

@implementation ViewController{
    BOOL playerOne;
    NSMutableArray *gameCells;
    NSNumber *cellNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startNewGame];
    
}

-(void)startNewGame{
    gameCells = [[NSMutableArray alloc]init];
    gameCells = [NSMutableArray arrayWithCapacity:9];
    playerOne = YES;
    self.whichPlayerLabel.text = @"Player One";
    
    for (int i=0;i<9;i++){
        [gameCells addObject:[NSNumber numberWithInt:0]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)onLabelTapped:(UIGestureRecognizer *)sender {
    UILabel *selectedLabel = (UILabel *)sender.view;
//    NSLog(@"Label %ld was tapped.",(long)selectedLabel.tag);
    [self fillLabel:selectedLabel];
}

-(void)fillLabel:(UILabel *)selectedLabel{
    long cellTag = selectedLabel.tag;
    
    if ([[gameCells objectAtIndex:cellTag]intValue] == 0) {
        if (playerOne) {
            selectedLabel.text = @"X";
            selectedLabel.textColor = [UIColor blueColor];
            [gameCells replaceObjectAtIndex:cellTag withObject:@1];
            self.whichPlayerLabel.text = @"Player One";
        }else{
            selectedLabel.text = @"O";
            selectedLabel.textColor = [UIColor redColor];
            [gameCells replaceObjectAtIndex:cellTag withObject:@2];
            self.whichPlayerLabel.text = @"Player Two";
        }
        
        if ([self gameWon]) {
            NSLog(@"Game Won");
        }
        playerOne = !playerOne;
        
    }
    
}

-(BOOL)checkRows{
    for (int i=0; i < 3; i++) {
        if ([self checkFirstCell:i withSecond:i + 3 andThird:i + 6]) {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)checkColumns{
    for (int i=0; i < 3; i++) {
        if ([self checkFirstCell:(i * 3) withSecond:(i * 3)+1 andThird:(i * 3)+2]) {
            return YES;
        }
    }

    return NO;
}


-(BOOL)checkFirstCell:(int)first withSecond:(int)second andThird:(int)third{
    if ([[gameCells objectAtIndex:first]intValue] == 0 || [[gameCells objectAtIndex:second]intValue] == 0 || [[gameCells objectAtIndex:third]intValue] == 0) {
        // All cells have to have a value in order to check
        return NO;
    }

    // If the cells are the same return YES
    return([[gameCells objectAtIndex:first]intValue] == [[gameCells objectAtIndex:second]intValue] && [[gameCells objectAtIndex:second]intValue] == [[gameCells objectAtIndex:third]intValue]);

}


-(BOOL)gameWon{
    return [self checkRows] || [self checkColumns] || [self checkFirstCell:0 withSecond:4 andThird:8] || [self checkFirstCell:2 withSecond:4 andThird:6];
}








@end