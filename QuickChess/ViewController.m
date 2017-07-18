//
//  ViewController.m
//  QuickChess
//
//  Created by Elaine Zhao on 6/26/17.
//  Copyright © 2017 Elaine Zhao. All rights reserved.
//

#import "ViewController.h"
#import "ResultsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int topSecondsLeft;
int bottomSecondsLeft;
bool topPaused;
bool bottomPaused;
NSTimer *topTimer;
NSTimer *bottomTimer;
bool gameStarted;
bool topWin;
NSString* currentPlayerStr;
NSString* topPlayerStr = @"TOP";
NSString* bottomPlayertStr = @"BOTTOM";
NSString* winResultStr = @"YOU WON";
NSString* loseResultStr = @"YOU RAN OUT OF TIME";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpBeforeStartGame];
    
    // rotate top label
    [_topTimeLabel setTransform:CGAffineTransformMakeRotation(-M_PI)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// change relevant variables so that ticks will update other player's time
- (void)swapTurn:(bool) toTop {
    if (toTop == true) {
        if (topTimer == nil) {
            [self createNewTimer: true];
        }
        bottomPaused = true;
        topPaused = false;
        currentPlayerStr = topPlayerStr;
    } else {
        if (bottomTimer == nil) {
            [self createNewTimer: false];
        }
        topPaused = true;
        bottomPaused = false;
        currentPlayerStr = bottomPlayertStr;
    }
}

// convert seconds to string with format mm:ss
- (NSString *) getTimeStringFromSeconds: (int) seconds {
    int minutes = seconds / 60;
    seconds = seconds % 60;
    return [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
}

// update top player's seconds left and time label if it's their timer is not paused
-(void)onTickTop:(NSTimer *)timer {
    if (topPaused == true) {
        return;
    }
    // end game, go to results view
    if (topSecondsLeft <= 0) {
        topWin = false;
        [self gameOver];
    // decrease current player's time and update time displayed
    } else {
        topSecondsLeft -=1;
        _topTimeLabel.text = [self getTimeStringFromSeconds:(topSecondsLeft)];
    }
}

// same as onTickTop but updates bottom times
-(void)onTickBottom:(NSTimer *)timer {
    if (bottomPaused == true) {
        return;
    }
    // end game, go to results view
    if (bottomSecondsLeft <= 0) {
        topWin = true;
        [self gameOver];
    // decrease current player's time and update time displayed
    } else {
        bottomSecondsLeft -=1;
        _bottomTimeLabel.text = [self getTimeStringFromSeconds:(bottomSecondsLeft)];
    }
}

// if first tap, start game and start the timer on this player's side
// else, swap to other player's turn
- (IBAction)playerButtonTapped:(UIButton *)sender {
    bool isTop = sender.tag; // TODO depends on tag convention
    // start game
    if (!gameStarted) {
        gameStarted = true;
        [self swapTurn: (isTop)];
    }
    // swap player if not paused
    else if (isTop && !topPaused) {
        [self swapTurn: (!isTop)];
    }
    else if (!isTop && !bottomPaused) {
        [self swapTurn: (!isTop)];
    }
}

- (IBAction)pauseResumeButtonPressed:(UIButton *)sender {
    if (gameStarted) {
        if (!topPaused || !bottomPaused) { // pause game
            [sender setImage:[UIImage imageNamed:@"Resume"] forState:UIControlStateNormal];
            topPaused = true;
            bottomPaused = true;
        } else { // resume game. change current player's paused to false
            [sender setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
            if ([currentPlayerStr isEqualToString:topPlayerStr]) {
                topPaused = false;
            } else {
                bottomPaused = false;
            }
        }
    }
}

// reset both timers
- (IBAction)refreshButtonPressed:(UIButton *)sender {
    if (gameStarted) {
        if (topTimer != nil) {
            [topTimer invalidate];
            topTimer = nil;
        }
        if (bottomTimer != nil) {
            [bottomTimer invalidate];
            bottomTimer = nil;
        }
        [self setUpBeforeStartGame];
        
    }
}

// sets players' time left to starting time
- (void) setUpBeforeStartGame {
    topSecondsLeft = _topStartingTime * 60;
    bottomSecondsLeft = _bottomStartingTime * 60;
    
    _topTimeLabel.text = [self getTimeStringFromSeconds:(topSecondsLeft)];
    _bottomTimeLabel.text = [self getTimeStringFromSeconds:(bottomSecondsLeft)];
    [_pauseButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
    gameStarted = false;
}

- (void) createNewTimer: (bool) forTop {
    if (forTop) {
        topTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                   target: self
                                                 selector:@selector(onTickTop:)
                                                 userInfo: nil repeats:YES];

    } else {
        bottomTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                 target: self
                                               selector:@selector(onTickBottom:)
                                               userInfo: nil repeats:YES];
    }
}

- (void) gameOver {
    [topTimer invalidate];
    topTimer = nil;
    [bottomTimer invalidate];
    bottomTimer = nil;
    [self performSegueWithIdentifier:@"segueToResultsViewController" sender:nil];
}

// set up result strings for top and bottom players depending on who won
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueToResultsViewController"]) {
        ResultsViewController *rvc = [segue destinationViewController];
        if (topWin) {
            rvc.topResultStr = winResultStr;
            rvc.bottomResultStr = loseResultStr;
        } else {
            rvc.topResultStr = loseResultStr;
            rvc.bottomResultStr = winResultStr;
        }
    }
}

@end
