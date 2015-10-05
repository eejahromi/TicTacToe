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
@property (assign, nonatomic) int touchCounter;

@property (strong,nonatomic) NSArray *labelsArray;

@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (assign, nonatomic) int number;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController{
    BOOL playerOne;
    NSMutableArray *gameCells;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.labelsArray = @[self.labelOne,
                         self.labelTwo,
                         self.labelThree,
                         self.labelFour,
                         self.labelFive,
                         self.labelSix,
                         self.labelSeven,
                         self.labelEight,
                         self.labelNine];
    
    [self startNewGame];
    self.timerLabel.text = @"";
    self.number = 10;
    
}

-(void)startNewGame{
    
    [gameCells removeAllObjects];
    
    if (!gameCells) {
        gameCells = [[NSMutableArray alloc]init];
        gameCells = [NSMutableArray arrayWithCapacity:9];
        
    }

    for (int i=0;i<9;i++){
        UILabel *label = [self.labelsArray objectAtIndex:i];
        label.backgroundColor = [UIColor colorWithRed:126/255.0 green:154/255.0 blue:190/255.0 alpha:1.0];
        label.text = @"";
        [gameCells addObject:[NSNumber numberWithInt:0]];
    }
    
    self.touchCounter = 0;
    playerOne = YES;
    self.whichPlayerLabel.text = @"PLAYER ONE";
    self.timerLabel.text = @"";
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onLabelTapped:(UIGestureRecognizer *)sender {
    UILabel *selectedLabel = (UILabel *)sender.view;
    [self fillLabel:selectedLabel];
}

-(void)fillLabel:(UILabel *)selectedLabel{
    self.touchCounter++;
    long cellTag = selectedLabel.tag;
    [self.timer invalidate];
    
    if ([[gameCells objectAtIndex:cellTag]intValue] == 0) {
        if (playerOne == YES) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
            [gameCells replaceObjectAtIndex:cellTag withObject:@1];
            selectedLabel.text = @"X";
            selectedLabel.textColor = [UIColor blueColor];
            self.number = 10;
            self.whichPlayerLabel.text = @"PLAYER TWO";
            
        }else{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
            [gameCells replaceObjectAtIndex:cellTag withObject:@2];
            selectedLabel.text = @"O";
            selectedLabel.textColor = [UIColor redColor];
            self.number = 10;
            self.whichPlayerLabel.text = @"PLAYER ONE";
        }
        
        if (self.touchCounter == 9 && ![self gameWon]) {
            // Game Tied
            [self.timer invalidate];
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Game Tied"
                                                                                message:@"Tough Competition. Game Tied!"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Start New Game"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [self startNewGame];
                                                           }];
            [controller addAction:action];
            [self presentViewController:controller animated:YES completion:nil];
        }
        
        if ([self gameWon]) {
            // Game Won
            [self.timer invalidate];
            [self whoWon:playerOne];
        }
        
        // Switch turns, update touch counter
        playerOne = !playerOne;
        
    }
    
}

-(void)startTimer{
    
    // Update time and counter
    self.timerLabel.text = [NSString stringWithFormat:@"%d",self.number--];
    
    if (self.number == -1) {
        [self.timer invalidate];
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
    
    // All cells have to have a value in order to check
    if ([[gameCells objectAtIndex:first]intValue] == 0 || [[gameCells objectAtIndex:second]intValue] == 0 || [[gameCells objectAtIndex:third]intValue] == 0) {
        
        return NO;
    }

    // If the cells are the same return YES
    if([[gameCells objectAtIndex:first]intValue] == [[gameCells objectAtIndex:second]intValue] && [[gameCells objectAtIndex:second]intValue] == [[gameCells objectAtIndex:third]intValue]){
        NSArray *winningCombo = @[[NSNumber numberWithInt:first],[NSNumber numberWithInt:second],[NSNumber numberWithInt:third]];
        
        for (NSNumber *number in winningCombo) {
            UILabel *label = [self.labelsArray objectAtIndex:[number intValue]];
            label.backgroundColor = [UIColor colorWithRed:126/255.0 green:154/255.0 blue:140/255.5 alpha:1.0];
        }
        
        return YES;
    }
    
    return NO;
}


-(BOOL)gameWon{
    return [self checkRows] || [self checkColumns] ||
    [self checkFirstCell:0 withSecond:4 andThird:8] ||
    [self checkFirstCell:2 withSecond:4 andThird:6];
}



-(void)whoWon:(BOOL)player{
    UIAlertController *alert;
    
    // Display alert depending on who won the game
    
    if (playerOne == YES) {
        alert = [UIAlertController alertControllerWithTitle:@"Congradulations"
                                                    message:@"Player One Won!"
                                             preferredStyle:UIAlertControllerStyleAlert];
    }else{
        alert = [UIAlertController alertControllerWithTitle:@"Congradulations"
                                                    message:@"Player Two Won!"
                                             preferredStyle:UIAlertControllerStyleAlert];
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                [self startNewGame];
                                                            }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}






@end