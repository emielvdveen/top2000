//
//  Hint.h
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <Foundation/Foundation.h>

// {"vraag":"Welke band zoeken we?","hint_1":"Begonnen onder de naam ","hint_2":"Echte naam van de zanger: Farrokh Bulsara","hint_3":"Brian May","hint_4":"Bohemian rhapsody","antwoord":"Queen"}

@interface Hint : NSObject
{
    NSString* vraag;
    NSString* hint1;
    NSString* hint2;
    NSString* hint3;
    NSString* hint4;
    NSString* antwoord;
}

@property(nonatomic, copy) NSString *vraag;
@property(nonatomic, copy) NSString *hint1;
@property(nonatomic, copy) NSString *hint2;
@property(nonatomic, copy) NSString *hint3;
@property(nonatomic, copy) NSString *hint4;
@property(nonatomic, copy) NSString *antwoord;

+ (Hint*) createFromJson:(NSDictionary*)jsonValues;

@end
