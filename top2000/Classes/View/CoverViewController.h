//
//  CoverViewController.h
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hoes;

@interface CoverViewController : UIViewController
{
    IBOutlet UIImageView* shadow;
    IBOutlet UIImageView* coverEdited;
    IBOutlet UIImageView* coverOriginal;
    IBOutlet UILabel* vraagLabel;
    IBOutlet UILabel* antwoordLabel;
    IBOutlet UIButton* antwoordBtn;

    Hoes * hoes;
}

@property(nonatomic, strong) Hoes *hoes;

- (IBAction) showAnswer;

@end
