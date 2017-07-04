//
//  ViewController.h
//  QuickChess
//
//  Created by Elaine Zhao on 6/26/17.
//  Copyright © 2017 Elaine Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *topTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *bottomTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@end

