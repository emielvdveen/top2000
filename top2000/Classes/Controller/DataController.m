//
//  DataController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "DataController.h"
#import "Singleton.h"
#import "SBJsonParser.h"
#import "PopQuizVraag.h"
#import "Hint.h"
#import "HitFragment.h"
#import "Hoes.h"
#import "Doorvraag.h"
#import "Foto.h"

@implementation DataController

@synthesize popQuizVragen = _popQuizVragen;
@synthesize doorVragen = _doorVragen;
@synthesize hints = _hints;
@synthesize hitFragmenten = _hitFragmenten;
@synthesize hoezen = _hoezen;
@synthesize fotos = _fotos;


#pragma mark - Singleton

+ (DataController*) sharedInstance;
{
	DEFINE_SHARED_INSTANCE_USING_BLOCK
    (^ 
     {
         return [[self alloc] init];
     }
     );
}

#pragma mark - Instance methods

- (NSArray*) loadJsonArray:(NSString*)filepath;
{
    NSError *error = nil;
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray* jsonValues = [parser objectWithString:jsonString];
    return jsonValues;
}

- (NSArray*) loadPopquizVragen;
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"popquizvragen" ofType:@"json"]; 
    return [self loadJsonArray:filePath];
}

- (NSDictionary*) loadDoorvragen;
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"doorvraag" ofType:@"json"]; 
    NSArray* doorvragen = [self loadJsonArray:filePath];    
    
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    
    for(NSDictionary* doorvraag in doorvragen)
    {
        NSNumber* key = [doorvraag objectForKey:@"vraag_nr"];
        NSMutableArray* doorvragenForKey = [result objectForKey:key];
        if (!doorvragenForKey)
        {
            doorvragenForKey = [[NSMutableArray alloc] init];
            [result setObject:doorvragenForKey forKey:key];
        }
        [doorvragenForKey addObject:doorvraag];
    }
    
    return result;
}

- (NSArray*) loadHints;
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hints" ofType:@"json"]; 
    return [self loadJsonArray:filePath];    
}

- (NSArray*) loadHitFragmenten;
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hitfragmenten" ofType:@"json"]; 
    return [self loadJsonArray:filePath];
}

- (NSArray*) loadHoezen;
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hoezen" ofType:@"json"]; 
    return [self loadJsonArray:filePath];
}

- (NSArray*) loadFotos;
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fotos" ofType:@"json"];
    return [self loadJsonArray:filePath];
}

- (void) loadAll;
{
    _doorVragen = [self loadDoorvragen];
    NSLog(@"%i doorvragen loaded", [_doorVragen count]);
    
    _hints = [self loadHints];
    NSLog(@"%i hints loaded", [_hints count]);

    _hitFragmenten = [self loadHitFragmenten];
    NSLog(@"%i hitfragmenten loaded", [_hitFragmenten count]);

    _popQuizVragen = [self loadPopquizVragen];
    NSLog(@"%i popquizvragen loaded", [_popQuizVragen count]);

    _hoezen = [self loadHoezen];
    NSLog(@"%i hoezen loaded", [_hoezen count]);

    _fotos = [self loadFotos];
    NSLog(@"%i fotos loaded", [_fotos count]);
}


- (int) totaalAantalVragen;
{
    return [_popQuizVragen count] + [_doorVragen count] + [_hints count] + [_hitFragmenten count] + [_hoezen count];
}

- (id) getVraag:(int)index;
{
    if (index < [_popQuizVragen count])
    {
        NSLog(@"Popquiz vraag");
        NSDictionary *jsonVraag = [_popQuizVragen objectAtIndex:index];
        PopQuizVraag *vraag = [PopQuizVraag createFromJson:jsonVraag];
        return vraag;
    }
    
    index = index - [_popQuizVragen count];
    
    if (index < [_doorVragen count])
    {
        NSLog(@"Doorvraag");

        NSArray* jsonVragen = [_doorVragen objectForKey:[NSNumber numberWithInt:index]];

        NSMutableArray *vragen = [[NSMutableArray alloc] init];

        for (NSDictionary *jsonVraag in jsonVragen)
        {
            Doorvraag *vraag = [Doorvraag createFromJson:jsonVraag];
            [vragen addObject:vraag];
        }
        return vragen;
    }
    
    index = index - [_doorVragen count];

    if (index < [_hints count])
    {
        NSLog(@"Hints vraag");
        NSDictionary *jsonVraag = [_hints objectAtIndex:index];
        Hint *vraag = [Hint createFromJson:jsonVraag];
        return vraag;
    }
    
    index = index - [_hints count];

    if (index < [_hitFragmenten count])
    {
        NSLog(@"Hit fragment");
        NSDictionary *jsonVraag = [_hitFragmenten objectAtIndex:index];
        HitFragment *vraag = [HitFragment createFromJson:jsonVraag];
        return vraag;
    }
    
    index = index - [_hitFragmenten count];

    if (index < [_hoezen count])
    {
        NSLog(@"Hoes vraag");
        NSDictionary *jsonVraag = [_hoezen objectAtIndex:index];
        Hoes *vraag = [Hoes createFromJson:jsonVraag];
        return vraag;
    }


    index = index - [_hoezen count];

    if (index < [_fotos count])
    {
        NSLog(@"Foto vraag");
        NSDictionary *jsonVraag = [_hoezen objectAtIndex:index];
        Foto *vraag = [Foto createFromJson:jsonVraag];
        return vraag;
    }

    return nil;
}


@end