//
//  Globals.h
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#define IPAD (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define IPHONE !IPAD
#define IPHONE5 ([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale) >=1136

