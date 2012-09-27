//
//  PopQuizViewController.h
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopQuizVraag;

@interface PopQuizViewController : UIViewController
{
    PopQuizVraag* vraag;

    UILabel*vraagLabel;
    UILabel* antwoordLabel;
    UIButton* antwoordBtn;
    
    IBOutlet UIImageView* background;
}

@property(nonatomic, strong) PopQuizVraag *vraag;

@property(nonatomic, strong) IBOutlet UILabel *vraagLabel;
@property(nonatomic, strong) IBOutlet UILabel *antwoordLabel;
@property(nonatomic, strong) IBOutlet UIButton *antwoordBtn;

- (IBAction) showAnswer;

@end
