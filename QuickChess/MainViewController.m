//  MainViewController.m
//  QuickChess
//
//  Created by Elaine Zhao on 7/5/17.
//  Copyright © 2017 Elaine Zhao. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueToViewController" sender:nil];
}

// set up starting time
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueToViewController"]) {
        ViewController *vc = [segue destinationViewController];
        vc.startingTime = [_inputTimeText.text floatValue];
    }
}

@end
