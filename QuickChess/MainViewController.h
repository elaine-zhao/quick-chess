//
//  MainViewController.h
//  QuickChess
//
//  Created by Elaine Zhao on 7/5/17.
//  Copyright © 2017 Elaine Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *topInputTimeText;

@property (weak, nonatomic) IBOutlet UITextField *bottomInputTimeText;

@end

