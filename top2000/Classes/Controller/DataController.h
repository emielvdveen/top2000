//
//  DataController.h
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject

@property (nonatomic, strong) NSArray* popQuizVragen;
@property (nonatomic, strong) NSDictionary* doorVragen;
@property (nonatomic, strong) NSArray* hints;
@property (nonatomic, strong) NSArray* hitFragmenten;
@property (nonatomic, strong) NSArray* hoezen;

+ (DataController*) sharedInstance;

- (NSArray*) loadPopquizVragen;
- (NSDictionary*) loadDoorvragen;
- (NSArray*) loadHints;
- (NSArray*) loadHitFragmenten;
- (NSArray*) loadHoezen;
- (void) loadAll;

- (int) totaalAantalVragen;
- (id) getVraag:(int)index;

@end
