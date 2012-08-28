//
//  GameController.h
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameController : NSObject

+ (GameController*) sharedInstance;

- (void) startGame:(int)rounds;
- (BOOL) hasNextRound;
- (id) nextRound;
- (id) round;

@end
