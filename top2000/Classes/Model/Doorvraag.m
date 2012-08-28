//
//  Doorvraag.m
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "Doorvraag.h"

@implementation Doorvraag

@synthesize vraagId = _vraagId;
@synthesize vraag = _vraag;
@synthesize antwoord = _antwoord;

+ (Doorvraag*) createFromJson:(NSDictionary*)jsonValues;
{
    // // {"vraag_nr":1,"vraag":"4 Non Blondes staan in de Top 2000 met het nummer……","antwoord":" 'What's Up'"},
    Doorvraag* result = [[Doorvraag alloc] init];
    result.vraagId = [jsonValues objectForKey:@"vraagNr"];
    result.vraag = [jsonValues objectForKey:@"vraag"];
    result.antwoord = [jsonValues objectForKey:@"antwoord"];
    return result;
}

@end
