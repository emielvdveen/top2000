//
//  StartViewControllerViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 9/9/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "StartViewController.h"
#import "MainViewController.h"
#import "GameController.h"
#import "DataController.h"
#import "Globals.h"

@interface StartViewController()
@end

@implementation StartViewController
{
    MainViewController *_mainVC;
    NSMutableArray *artists;
    int _artistCounter;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _artistCounter = 0;
        artists = [[NSMutableArray alloc] init];
    }
    return self;
}

- (float) width
{
    return  IPAD ? 1024 : 320;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DataController sharedInstance] loadAll];

    subtitle.transform = CGAffineTransformMakeTranslation(0, -CGRectGetMaxY(subtitle.frame));
    
    sponsorLogos.transform = CGAffineTransformMakeTranslation(-CGRectGetMaxX(sponsorLogos.frame), 0);
    startLabel.transform = CGAffineTransformMakeTranslation([self width]-startButton.frame.origin.x, 0);
    startButton.transform = CGAffineTransformMakeTranslation([self width]-startButton.frame.origin.x, 0);
    
    if (IPAD)
    {
        [artists addObject:amyWhinehouse];
        [artists addObject:guusMeeuwis];
        [artists addObject:allmanBrothers];
        [artists addObject:abba];
        [artists addObject:donnaSummer];
        [artists addObject:frankSinatra];
        [artists addObject:davidBowie];
        [artists addObject:ilseDeLange];
        [artists addObject:goldenEarring];
        [artists addObject:u2];
        [artists addObject:bonJovi];
        [artists addObject:marcoBorsato];
        [artists addObject:sting];
        [artists addObject:markKnopfler];
        [artists addObject:caroEmerald];
        [artists addObject:theWho];
        [artists addObject:gunsnroses];
        [artists addObject:kiss];
        [artists addObject:queen];
        [artists addObject:clapton];
        [artists addObject:bdg];
        [artists addObject:stevieWonder];
        [artists addObject:jamesBrown];
        [artists addObject:eltonJohn];
        [artists addObject:dianaRoss];
        [artists addObject:bobMarley];
        [artists addObject:commodores];
        [artists addObject:marvinGaye];
    
        for (UIImageView *artist in artists)
        {
            artist.alpha = 0;
        }
        
        _artistCounter = 0;
        [self showNextArtistOnIpad];
    }
    else
    {
        startLabel.alpha = 0;
        artistsImageView.alpha = 0;
        [self showArtistsOnIphone];
    }
}

- (void) showArtistsOnIphone;
{
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationCurveLinear animations:^{
        artistsImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [self showSponsorLogos];
        [self showStartButton];
    }];
}

- (void) showNextArtistOnIpad;
{
    if (_artistCounter >= [artists count])
    {
        return;
    }
    
    UIImageView* artist1;
    UIImageView* artist2;

    artist1 = [artists objectAtIndex:_artistCounter];
    if (_artistCounter+1 < [artists count])
    {
        artist2 = [artists objectAtIndex:_artistCounter+1];
    }
    
    
    float duration = 1. / (_artistCounter+1);
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        artist1.alpha = 1;
    } completion:nil];
    
    [UIView animateWithDuration:duration delay:duration/2 options:UIViewAnimationCurveEaseOut animations:^{
        artist2.alpha = 1;
    } completion:^(BOOL finished) {
        if (_artistCounter < [artists count]/2 && _artistCounter+3 >= [artists count]/2)
        {
            [self showSubtitle];
        }
        _artistCounter = _artistCounter+2;
        [self showNextArtistOnIpad];
    }];
    
}

- (void) showSubtitle;
{
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        subtitle.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [self showSponsorLogos];
    }];
}

- (void) showSponsorLogos;
{
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        sponsorLogos.transform = CGAffineTransformMakeTranslation(0, 0);
        [self showStartButton];
    } completion:^(BOOL finished) {
    }];
}

- (void) showStartButton;
{
    startLabel.alpha = 1;
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        startButton.transform = CGAffineTransformMakeTranslation(0, 0);
        startLabel.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
    }];
}
     
- (void)viewDidUnload
{
    popup = nil;
    vragen25Btn = nil;
    vragen50Btn = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (IPAD)
    {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    }
    else {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    }
}

//- (BOOL)shouldAutorotate {
//    UIInterfaceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
//    if (IPAD)
//    {
//        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
//    }
//    else {
//        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
//    }
//}

- (NSUInteger)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0);
{
    if (IPAD)
    {
        return UIInterfaceOrientationMaskLandscape;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (IBAction) startGame;
{
    [self showPopup];
}

- (void) showPopup;
{
    popup.alpha = 0;
    if (IPHONE5)
    {
        CGRect frame = popup.frame;
        frame.size.height = 568;
        popup.frame = frame;
    }
    
    [self.view addSubview:popup];    
    
    [UIView animateWithDuration:0.5 animations:^{
        popup.alpha = 1;
    }];
}

- (void) hidePopup;
{
    [UIView animateWithDuration:0.5 animations:^{
        popup.alpha = 0;
    } completion:^(BOOL finished) {
        [popup removeFromSuperview];
    }];
}

- (void) showGame;
{
    _mainVC = [[MainViewController alloc] initWithNibName:(IPAD ? @"MainView~ipad" : @"MainView~iphone") bundle:nil];
    [self presentModalViewController:_mainVC animated:YES];
}

#pragma mark - Button clicks

- (IBAction)vragen25BtnClicked:(id)sender 
{
    [[GameController sharedInstance] startGame:ROUNDS_COUNT_25];
    [self showGame];
    [self hidePopup];
}

- (IBAction)vragen50BtnClicked:(id)sender 
{
    [[GameController sharedInstance] startGame:ROUNDS_COUNT_50];
    [self showGame];
    [self hidePopup];
}



@end
