//
//  ASSTime.h
//  GrosoSub
//
//  Created by Josu López Fernández on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ASSTime : NSObject {
	CGFloat time;
}

@property (assign) CGFloat time;

- (NSString *) description;
- (void) parseString:(NSString *)aString;
- (id) initWithString:(NSString *)aString; // Designated initializer

@end
