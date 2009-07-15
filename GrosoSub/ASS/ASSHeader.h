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
}

@property (retain) NSMutableDictionary *headerList;

- (id) init;
- (NSString *) description;

- (void) setValue:(NSString *)aValue forKey:(NSString *)aKey;
- (NSString *) getValueForKey:(NSString *)aKey;
- (NSUInteger) count;
- (void) clean;

- (id) initWithString:(NSString *)aString;
- (void) parseString:(NSString *)aString;

@end
