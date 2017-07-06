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

int topSecondsLeft; // TODO make millis
int bottomSecondsLeft;
bool isTopTurn;
int curPlayerSecondsLeft;
UILabel *curPlayerTimeLabel;
NSTimer *timer;
bool gameStarted;
bool topWin;
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
        isTopTurn = true;
        curPlayerSecondsLeft = topSecondsLeft;
        curPlayerTimeLabel = _topTimeLabel;
    } else {
        isTopTurn = false;
        curPlayerSecondsLeft = bottomSecondsLeft;
        curPlayerTimeLabel = _bottomTimeLabel;
    }
}

// convert seconds to string with format mm:ss
- (NSString *) getTimeStringFromSeconds: (int) seconds {
    int minutes = seconds / 60;
    seconds = seconds % 60;
    return [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
}

// subtract from current player's seconds left
// convert to string and set player's time label
// update that player's seconds left
-(void)onTick:(NSTimer *)timer {
    // end game, go to results view
    if (curPlayerSecondsLeft <= 0) {
        topWin = !isTopTurn;
        [self performSegueWithIdentifier:@"segueToResultsViewController" sender:nil];
    // decrease current player's time and update time displayed
    } else {
        curPlayerSecondsLeft -=1;
        curPlayerTimeLabel.text = [self getTimeStringFromSeconds:(curPlayerSecondsLeft)];
        if (isTopTurn) {
            topSecondsLeft = curPlayerSecondsLeft;
        } else {
            bottomSecondsLeft = curPlayerSecondsLeft;
        }
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
        [self createNewTimer];
    }
    // swap player if not paused
    else if (timer != nil) {
        [self swapTurn: (!isTop)];
    }
}

- (IBAction)pauseResumeButtonPressed:(UIButton *)sender {
    if (gameStarted) {
        if (timer != nil) { // pause game
            [timer invalidate];
            timer = nil;
            [sender setImage:[UIImage imageNamed:@"Resume"] forState:UIControlStateNormal];
        } else { // resume game
            [self createNewTimer];
            [sender setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
        }
    }
}

// reset both timers
- (IBAction)refreshButtonPressed:(UIButton *)sender {
    if (gameStarted) {
        if (timer != nil) {
            [timer invalidate];
            timer = nil;
        }
        [self setUpBeforeStartGame];
        
    }
}

// sets players' time left to starting time
- (void) setUpBeforeStartGame {
    topSecondsLeft = _startingTime * 60;
    bottomSecondsLeft = _startingTime * 60;
    
    _topTimeLabel.text = [self getTimeStringFromSeconds:(topSecondsLeft)];
    _bottomTimeLabel.text = [self getTimeStringFromSeconds:(bottomSecondsLeft)];
    [_pauseButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
    gameStarted = false;
}

// TODO slight cheat bc always get full second after resume
- (void) createNewTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                             target: self
                                           selector:@selector(onTick:)
                                           userInfo: nil repeats:YES];
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
