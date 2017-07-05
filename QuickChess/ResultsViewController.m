//
//  ResultsViewController.m
//  QuickChess
//
//  Created by Elaine Zhao on 7/5/17.
//  Copyright © 2017 Elaine Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultsViewController.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // rotate top label
    [_topResultLabel setTransform:CGAffineTransformMakeRotation(-M_PI)];
    
}

@end
