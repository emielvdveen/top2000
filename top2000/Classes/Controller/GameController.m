//
//  GameController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "GameController.h"
#import "Singleton.h"
#import "DataController.h"

@implementation GameController
{
    int _totaalAantalVragen;
    int _rounds;
    NSMutableArray *_finishedRounds;
    id _round;
}

+ (GameController*) sharedInstance;
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK
       (^
        {
            return [[self alloc] init];
        }
        );
}

- (void) startGame:(int)rounds;
{
    _rounds = rounds;
    _finishedRounds = [[NSMutableArray alloc] init];
    _totaalAantalVragen = [[DataController sharedInstance] totaalAantalVragen];
}

- (BOOL) hasNextRound;
{
    return [_finishedRounds count] < _rounds;
}

- (id) round;
{
    return _round;
}

- (id) nextRound;
{
//    _round = [[DataController sharedInstance] getVraag:979];
//    return _round;
    
    if (![self hasNextRound])
    {
        return nil;
    }
    
    int random = arc4random_uniform(_totaalAantalVragen);
    while ([_finishedRounds containsObject:[NSNumber numberWithInt:random]])
    {
        random = arc4random_uniform(_totaalAantalVragen);
    }
    
    _round = [[DataController sharedInstance] getVraag:random];
    NSLog(@"next round: %i", random);
    [_finishedRounds addObject:[NSNumber numberWithInt:random]];
    return _round;
}

@end
