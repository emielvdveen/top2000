//
//  PopQuizVraag.m
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "PopQuizVraag.h"

@implementation PopQuizVraag
@synthesize vraagNr;
@synthesize vraag;
@synthesize antwoord;


+ (PopQuizVraag*) createFromJson:(NSDictionary*)jsonValues;
{
// {"vraag_nr":1,"vraag":" When A Man Loves A Woman' was een hit van welke soulzanger?","antwoord":"Percy Sledge"}    Hoes* result = [[Hoes alloc] init];
    PopQuizVraag* result = [[PopQuizVraag alloc] init];
    result.vraagNr = [jsonValues objectForKey:@"vraag_nr"];
    result.vraag = [jsonValues objectForKey:@"vraag"];
    result.antwoord = [jsonValues objectForKey:@"antwoord"];
    return result;
}

@end
