//
//  HintsViewController.h
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hint;

@interface HintsViewController : UIViewController
{
    Hint* hint;

    UILabel*vraagLabel;
    UILabel* hint1Label;
    UILabel* hint2Label;
    UILabel* hint3Label;
    UILabel* hint4Label;
    UILabel* antwoordLabel;

    UIButton* antwoordBtn;
}

@property(nonatomic, strong) Hint *hint;

@property(nonatomic, strong) IBOutlet UILabel *vraagLabel;
@property(nonatomic, strong) IBOutlet UILabel *hint1Label;
@property(nonatomic, strong) IBOutlet UILabel *hint2Label;
@property(nonatomic, strong) IBOutlet UILabel *hint3Label;
@property(nonatomic, strong) IBOutlet UILabel *hint4Label;
@property(nonatomic, strong) IBOutlet UILabel *antwoordLabel;

@property(nonatomic, strong) IBOutlet UIButton *antwoordBtn;


- (IBAction) showAnswer;

@end
