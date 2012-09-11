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

@property(nonatomic, strong) Hint *hint;

@property(nonatomic, strong) IBOutlet UILabel *vraagLabel;
@property(nonatomic, strong) IBOutlet UILabel *hint1Label;
@property(nonatomic, strong) IBOutlet UILabel *hint2Label;
@property(nonatomic, strong) IBOutlet UILabel *hint3Label;
@property(nonatomic, strong) IBOutlet UILabel *hint4Label;
@property(nonatomic, strong) IBOutlet UILabel *hint1TitleLabel;
@property(nonatomic, strong) IBOutlet UILabel *hint2TitleLabel;
@property(nonatomic, strong) IBOutlet UILabel *hint3TitleLabel;
@property(nonatomic, strong) IBOutlet UILabel *hint4TitleLabel;

@property(nonatomic, strong) IBOutlet UIActivityIndicatorView *hint2Indicator;
@property(nonatomic, strong) IBOutlet UIActivityIndicatorView *hint3Indicator;
@property(nonatomic, strong) IBOutlet UIActivityIndicatorView *hint4Indicator;

@property(nonatomic, strong) IBOutlet UILabel *antwoordLabel;

@property(nonatomic, strong) IBOutlet UIButton *antwoordBtn;


- (IBAction) showAnswer;

@end
