//
//  ASSStyleList.h
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ASSStyle.h"

@interface ASSStyleList : NSObject {
	NSMutableArray *styles;
	NSMutableArray *styleNames;
}

@property (retain) NSMutableArray *styles;
@property (retain) NSMutableArray *styleNames;

- (void) addStyleFromString:(NSString *)aString;
- (void) addStyleFromString:(NSString *)aString atIndex:(NSUInteger)index;
- (void) changeStyleFromString:(NSString *)aString atIndex:(NSUInteger)index;
- (void) delStyleAtIndex:(NSUInteger)index;

- (ASSStyle *) getStyleAtIndex:(NSUInteger)index;

- (NSUInteger) countStyles;
- (void) clean;

- (void) parseString:(NSString *)aString;

- (id) initWithString:(NSString *)aString;
- (id) init;

- (NSString *) description;

@end
