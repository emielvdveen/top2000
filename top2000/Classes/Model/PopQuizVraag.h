//
//  PopQuizVraag.h
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopQuizVraag : NSObject
{
    NSNumber *vraagNr;
    NSString *vraag;
    NSString *antwoord;
}

@property(nonatomic, copy) NSNumber *vraagNr;
@property(nonatomic, copy) NSString *vraag;
@property(nonatomic, copy) NSString *antwoord;

+ (PopQuizVraag*) createFromJson:(NSDictionary*)jsonValues;

@end
