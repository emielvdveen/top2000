//
//  CoverViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "CoverViewController.h"
#import "Hoes.h"
#import "UIImage+iPhone5.h"
#import "Globals.h"

@interface CoverViewController ()

@end

@implementation CoverViewController

@synthesize hoes = _hoes;


- (void)viewDidLoad
{
    [super viewDidLoad];
    coverOriginal.alpha = 0;
    antwoordLabel.alpha = 0;
}

- (void) viewDidAppear:(BOOL)animated
{
    if (IPHONE5)
    {
        background.image = [UIImage imageNamedForDevice:@"cover_background_iphone"];
        CGRect frame = self.view.frame;
        frame.size.height = 568;
        self.view.frame = frame;
    }
    
    vraagLabel.text = _hoes.vraag;
    antwoordLabel.text = _hoes.antwoord;
    coverEdited.image = [_hoes editedImage];
    coverOriginal.image = [_hoes originalImage];
}

- (void) viewDidDisappear:(BOOL)animated
{
    coverEdited.image = nil;
    coverOriginal.image = nil;
}

- (IBAction) showAnswer;
{
    antwoordLabel.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoordBtn.alpha = 0;
        antwoordLabel.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
    coverOriginal.alpha = 1;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveLinear animations:^{
        coverEdited.alpha = 0;
    } completion:^(BOOL finished) {
        // nothing
    }];
}

- (void) dealloc
{
    NSLog(@"CoverViewController dealloc");
}

@end
