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
    _topInputTimeText.delegate = self;
    _bottomInputTimeText.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueToViewController" sender:nil];
}

// hide keyboard after click done/return
- (bool)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _topInputTimeText || textField == _bottomInputTimeText) {
        [textField resignFirstResponder];
    }
    return YES;
}

// hide keyboard after tap outside keyboard 
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// set up starting time
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueToViewController"]) {
        ViewController *vc = [segue destinationViewController];
        vc.topStartingTime = [_topInputTimeText.text floatValue];
        vc.bottomStartingTime = [_bottomInputTimeText.text floatValue];
    }
}

@end
