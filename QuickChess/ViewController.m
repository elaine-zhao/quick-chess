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

int topSecondsLeft = 540;
int bottomSecondsLeft = 540;
NSString *topTimeString = @"09:00";
NSString *bottomTimeString = @"09:00";
NSTimer *timer = nil;
int secondsLeft = 0;
UILabel *timeLabel = nil;
NSDateFormatter *dateFormat = nil;
bool isTopTurn = true;
int ticks = 0;

// TODO: release NSDateFormatter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _bottomTime.text = bottomTimeString;
    _topTime.text = topTimeString;
    
    // rotate top label
    [_topTime setTransform:CGAffineTransformMakeRotation(-M_PI)];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"mm:ss"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swapTurn:(bool) toTop {
    if (toTop == true) {
        isTopTurn = true;
        timeString = topTimeString;
        timeLabel = _topTime;
    } else {
        isTopTurn = false;
        timeString = bottomTimeString;
        timeLabel = _bottomTime;
    }
}

- (NSString *) getTimeStringFromSeconds: (int) seconds {
    int minutes = seconds / 60;
    seconds = seconds % 60;
    return [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    
}


// converts turn's time to date, subtracts 1 second, set label to new date
-(void)onTick:(NSTimer *)timer {
    ticks += 1;
    NSLog(@"%d", ticks);

    
    timeLabel.text =
    
    
}



- (IBAction)topButtonTapped:(UIButton *)sender {
    if (timer == nil) {
        [self swapTurn: (true)];
        timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                    target: self
                                                  selector:@selector(onTick:)
                                                  userInfo: nil repeats:YES];
        NSLog(@"timer did not exist. is top turn.");
    } else {
        [self swapTurn: (false)];
        NSLog(@"timer existed. is now bottom turn.");

    }

}


- (IBAction)bottomButtonTapped:(UIButton *)sender {
    if (timer == nil) {
        [self swapTurn: (false)];
        timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                 target: self
                                               selector:@selector(onTick:)
                                               userInfo: nil repeats:YES];
        NSLog(@"timer did not exist. is bottom turn.");
    } else {
        [self swapTurn: (true)];
        NSLog(@"timer existed. is now top turn");
    }
    
}




@end
