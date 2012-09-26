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
{
    NSMutableArray* _mp3List;
}

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

- (void) loadMP3List;
{
    _mp3List = [[NSMutableArray alloc] init];
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSArray *dirContents = [[NSFileManager defaultManager]  contentsOfDirectoryAtPath:bundleRoot error:nil];
    for (NSString *filename in dirContents) {
        if ([filename hasSuffix:@".mp3"])
        {
            [_mp3List addObject:[filename substringToIndex:[filename length]-4]];
        }
    }
}

- (NSString*) getMP3:(HitFragment*)vraag;
{
    for(NSString* mp3 in _mp3List)
    {
        NSRange range = [[mp3 uppercaseString] rangeOfString: [vraag.titel uppercaseString]];
        if (range.location != NSNotFound)
        {
            return mp3;
        }
    }
    return nil;
}

- (void) loadAll;
{
    [self loadMP3List];
    
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
    return [_popQuizVragen count] + [_doorVragen count] + [_hints count] + [_hitFragmenten count] + [_hoezen count] + [_fotos count];
}

- (id) getVraag:(int)index;
{
    
    if (index < [_doorVragen count])
    {
        NSArray* jsonVragen = [_doorVragen objectForKey:[NSNumber numberWithInt:index+1]];

        NSMutableArray *vragen = [[NSMutableArray alloc] init];

        for (NSDictionary *jsonVraag in jsonVragen)
        {
            Doorvraag *vraag = [Doorvraag createFromJson:jsonVraag];
            [vragen addObject:vraag];
        }
        return vragen;
    }
    
    index = index - [_doorVragen count];

    if (index < [_popQuizVragen count])
    {
        NSDictionary *jsonVraag = [_popQuizVragen objectAtIndex:index];
        PopQuizVraag *vraag = [PopQuizVraag createFromJson:jsonVraag];
        return vraag;
    }
    
    index = index - [_popQuizVragen count];

    if (index < [_hints count])
    {
        NSDictionary *jsonVraag = [_hints objectAtIndex:index];
        Hint *vraag = [Hint createFromJson:jsonVraag];
        return vraag;
    }
    
    index = index - [_hints count];

    if (index < [_hitFragmenten count])
    {
        NSDictionary *jsonVraag = [_hitFragmenten objectAtIndex:index];
        HitFragment *vraag = [HitFragment createFromJson:jsonVraag];
        vraag.mp3Filename = [self getMP3:vraag];
        return vraag;
    }
    
    index = index - [_hitFragmenten count];

    if (index < [_hoezen count])
    {
        NSDictionary *jsonVraag = [_hoezen objectAtIndex:index];
        Hoes *vraag = [Hoes createFromJson:jsonVraag];
        return vraag;
    }

    index = index - [_hoezen count];

    if (index < [_fotos count])
    {
        NSDictionary *jsonVraag = [_fotos objectAtIndex:index];
        Foto *vraag = [Foto createFromJson:jsonVraag];
        return vraag;
    }

    return nil;
}


@end
