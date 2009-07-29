//
//  ASSHeader.h
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ASSHeader : NSObject {
	NSMutableDictionary *headerList;
	NSMutableArray *order;
}

@property (retain) NSMutableDictionary *headerList;
@property (retain) NSMutableArray *order;

- (id) init;
- (NSString *) description;

- (void) setValue:(NSString *)aValue forKey:(NSString *)aKey;
- (NSString *) getValueForKey:(NSString *)aKey;
- (NSUInteger) count;
- (void) delKey:(NSString *)aKey;
- (void) clean;

- (id) initWithString:(NSString *)aString;
- (void) parseString:(NSString *)aString;

@end
