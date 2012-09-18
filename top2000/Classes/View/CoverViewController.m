//
//  CoverViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "CoverViewController.h"
#import "Hoes.h"

@interface CoverViewController ()

@end

@implementation CoverViewController

@synthesize hoes = _hoes;


- (void)viewDidLoad
{
    [super viewDidLoad];
    vraagLabel.text = _hoes.vraag;
    antwoordLabel.text = _hoes.antwoord;
    coverEdited.image = [_hoes editedImage];
    coverOriginal.image = [_hoes originalImage];
    coverOriginal.alpha = 0;
}

- (void) viewWillDisappear:(BOOL)animated
{
        
}

- (IBAction) showAnswer;
{
    antwoordLabel.alpha = 0;
    antwoordLabel.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoordBtn.alpha = 0;
        antwoordLabel.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
    
    coverOriginal.alpha = 1;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveLinear animations:^{
//        coverOriginal.alpha = 1;
        coverEdited.alpha = 0;
    } completion:^(BOOL finished) {
        // nothing
    }];
    
}

@end
