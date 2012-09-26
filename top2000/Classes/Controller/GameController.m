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

#import "PopQuizVraag.h"
#import "HitFragment.h"
#import "Hint.h"
#import "Hoes.h"
#import "Foto.h"

@implementation GameController
{
    int _totaalAantalVragen;
    int _rounds;
    NSMutableArray *_finishedRounds;
    id _round;
    
    int _countPopQuizVragen;
    int _countHitFragmenten;
    int _countHints;
    int _countHoezen;
    int _countFotos;
    int _countDoorVragen;
    int _countTotal;
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

- (void) processNextRoundTest;
{
    if ([_round isKindOfClass:[NSArray class]])
    {
        _countDoorVragen++;
    }
    else if ([_round isKindOfClass:[PopQuizVraag class]])
    {
        _countPopQuizVragen++;
    }
    else if ([_round isKindOfClass:[Hint class]])
    {
        _countHints++;
    }
    else if ([_round isKindOfClass:[HitFragment class]])
    {
        _countHitFragmenten++;
    }
    else if ([_round isKindOfClass:[Hoes class]])
    {
        _countHoezen++;
    }
    else if ([_round isKindOfClass:[Foto class]])
    {
        _countFotos++;
    }
}

- (void) nextRoundTest;
{
    NSLog(@"%i", _countTotal);

    if ([_finishedRounds count] > 50)
    {
        [_finishedRounds removeAllObjects];
    }
    
    if (_countTotal > 10000)
    {
        NSLog(@"_countPopQuizVragen %i", _countPopQuizVragen);
        NSLog(@"_countHitFragmenten %i", _countHitFragmenten);
        NSLog(@"_countHints %i", _countHints);
        NSLog(@"_countHoezen %i", _countHoezen);
        NSLog(@"_countFotos %i", _countFotos);
        NSLog(@"_countDoorVragen %i", _countDoorVragen);
        
        _countTotal = 0;
        
        return;
    }
    
    int random = arc4random_uniform(_totaalAantalVragen);
    while ([_finishedRounds containsObject:[NSNumber numberWithInt:random]])
    {
        random = arc4random_uniform(_totaalAantalVragen);
    }
    
    _round = [[DataController sharedInstance] getVraag:random];
    [self processNextRoundTest];
    
    [_finishedRounds addObject:[NSNumber numberWithInt:random]];
    
    _countTotal++;
    [self performSelector:@selector(nextRoundTest) withObject:nil afterDelay:0.0001];
}

- (id) nextRound;
{
    // 74, 638
    
//    _round = [[DataController sharedInstance] getVraag:74];
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
