//
//  Hint.m
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "Hint.h"

@implementation Hint
@synthesize vraag;
@synthesize hint1;
@synthesize hint2;
@synthesize hint3;
@synthesize hint4;
@synthesize antwoord;

+ (Hint*) createFromJson:(NSDictionary*)jsonValues;
{
// {"vraag":"Welke band zoeken we?","hint_1":"Begonnen onder de naam ","hint_2":"Echte naam van de zanger: Farrokh Bulsara","hint_3":"Brian May","hint_4":"Bohemian rhapsody","antwoord":"Queen"}
    Hint* result = [[Hint alloc] init];
    result.vraag = [jsonValues objectForKey:@"vraag"];
    result.hint1 = [jsonValues objectForKey:@"hint_1"];
    result.hint2 = [jsonValues objectForKey:@"hint_2"];
    result.hint3 = [jsonValues objectForKey:@"hint_3"];
    result.hint4 = [jsonValues objectForKey:@"hint_4"];
    result.antwoord = [jsonValues objectForKey:@"antwoord"];
    return result;
}

@end
