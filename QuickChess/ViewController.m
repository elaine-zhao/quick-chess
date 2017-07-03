//
//  ViewController.m
//  QuickChess
//
//  Created by Elaine Zhao on 6/26/17.
//  Copyright © 2017 Elaine Zhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int topSecondsLeft = 540; // TODO have players set
int bottomSecondsLeft = 540;
bool isTopTurn = true;
int curPlayerSecondsLeft;
UILabel *curPlayerTimeLabel;
NSTimer *timer;
bool gameStarted = false;
bool isPaused = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _topTimeLabel.text = [self getTimeStringFromSeconds:(topSecondsLeft)];
    _bottomTimeLabel.text = [self getTimeStringFromSeconds:(bottomSecondsLeft)];
    
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
    curPlayerSecondsLeft -=1;
    curPlayerTimeLabel.text = [self getTimeStringFromSeconds:(curPlayerSecondsLeft)];
    if (isTopTurn) {
        topSecondsLeft = curPlayerSecondsLeft;
    } else {
        bottomSecondsLeft = curPlayerSecondsLeft;
    }
}

// if first tap, start game and start the timer on this player's side
// else, swap to other player's turn
- (IBAction)playerButtonTapped:(UIButton *)sender {
    bool isTop = sender.tag; // TODO depends on tag convention
    // start game
    if (!gameStarted) {
        gameStarted = true;
        NSLog(@"%d", isTop);
        [self swapTurn: (isTop)];
        [self createNewTimer];
    }
    // swap player if not paused
    else if (!isPaused) {
        [self swapTurn: (!isTop)];
    }
}

- (IBAction)pauseResumeButtonPressed:(UIButton *)sender {
    if (gameStarted) {
        if (!isPaused) { // pause game
            [timer invalidate];
            timer = nil;
            isPaused = true;
        } else { // resume game
            [self createNewTimer];
            isPaused = false;
        }
    }
}

// TODO slight cheat bc always get full second after resume
- (void) createNewTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                             target: self
                                           selector:@selector(onTick:)
                                           userInfo: nil repeats:YES];
}

@end
