//
//  QuestionsViewController.h
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Doorvraag;

@interface QuestionsViewController : UIViewController
{
    IBOutlet UIImageView* background;    
}

@property (nonatomic, strong) NSArray *doorvragen;

@property (nonatomic, strong) IBOutlet UILabel *vraag1TitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *vraag2TitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *vraag3TitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *vraag4TitleLabel;

@property (nonatomic, strong) IBOutlet UILabel *vraag1Label;
@property (nonatomic, strong) IBOutlet UILabel *vraag2Label;
@property (nonatomic, strong) IBOutlet UILabel *vraag3Label;
@property (nonatomic, strong) IBOutlet UILabel *vraag4Label;

@property (nonatomic, strong) IBOutlet UILabel *antwoord4Label;
@property (nonatomic, strong) IBOutlet UILabel *antwoord1Label;
@property (nonatomic, strong) IBOutlet UILabel *antwoord2Label;
@property (nonatomic, strong) IBOutlet UILabel *antwoord3Label;

@property (nonatomic, strong) IBOutlet UIButton *antwoord1Btn;
@property (nonatomic, strong) IBOutlet UIButton *antwoord2Btn;
@property (nonatomic, strong) IBOutlet UIButton *antwoord3Btn;
@property (nonatomic, strong) IBOutlet UIButton *antwoord4Btn;

- (IBAction) showAnswer1;
- (IBAction) showAnswer2;
- (IBAction) showAnswer3;
- (IBAction) showAnswer4;

@end
