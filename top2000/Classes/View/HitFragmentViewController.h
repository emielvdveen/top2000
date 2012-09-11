//
//  HitFragmentViewController.h
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class HitFragment;

@interface HitFragmentViewController : UIViewController <AVAudioPlayerDelegate>

@property(nonatomic, strong) IBOutlet UIProgressView *progressView;
@property(nonatomic, strong) IBOutlet UIButton *playBtn;
@property(nonatomic, strong) IBOutlet UILabel *playLabel;

@property(nonatomic, strong) IBOutlet UILabel *antwoord1Label;
@property(nonatomic, strong) IBOutlet UILabel *antwoord2Label;
@property(nonatomic, strong) IBOutlet UIButton *antwoord1Btn;
@property(nonatomic, strong) IBOutlet UIButton *antwoord2Btn;

@property(nonatomic, strong) HitFragment *hitFragment;

- (IBAction) playBtnClicked:(id)sender;
- (IBAction) antwoord1BtnClicked:(id)sender;
- (IBAction) antwoord2BtnClicked:(id)sender;

- (void) stopPlayback;

@end
