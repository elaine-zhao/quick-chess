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

NSString *topTimeString = @"09:00";
NSString *bottomTimeString = @"09:00";
NSTimer *timer = nil;
bool isTopTurn = true;
int ticks = 0;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _bottomTime.text = bottomTimeString;
    _topTime.text = topTimeString;
    
    // rotate top label
    [_topTime setTransform:CGAffineTransformMakeRotation(-M_PI)];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// converts turn's time to date, subtracts 1 second, set label to new date
-(void)onTick:(NSTimer *)timer {
    ticks += 1;
    NSLog(@"%d", ticks);
}



- (IBAction)topButtonTapped:(UIButton *)sender {
    if (timer == nil) {
        isTopTurn = true;
        timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                    target: self
                                                  selector:@selector(onTick:)
                                                  userInfo: nil repeats:YES];
        NSLog(@"timer did not exist. is top turn.");
    } else {
        isTopTurn = false;
        NSLog(@"timer existed. is now bottom turn.");

    }

}


- (IBAction)bottomButtonTapped:(UIButton *)sender {
    if (timer == nil) {
        isTopTurn = false;
        timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                 target: self
                                               selector:@selector(onTick:)
                                               userInfo: nil repeats:YES];
        NSLog(@"timer did not exist. is bottom turn.");
    } else {
        isTopTurn = true;
        NSLog(@"timer existed. is now top turn");
    }
    
}




@end
