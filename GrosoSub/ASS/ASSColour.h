//
//  ASSColour.h
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ASSColour : NSObject {
	NSUInteger alpha, red, green, blue;
}

@property (assign) NSUInteger alpha;
@property (assign) NSUInteger red;
@property (assign) NSUInteger green;
@property (assign) NSUInteger blue;

- (NSString *) description;
- (void) parseString:(NSString *)aString;
- (id) initWithString:(NSString *)aString;
- (id) init;

@end
