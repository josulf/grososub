//
//  ASSStyle.h
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ASSColour;

@interface ASSStyle : NSObject {
	NSString *name, *fontName;
	NSInteger fontSize;
	ASSColour *primaryColour, *secondaryColour, *outlineColour, *backColour;
	Boolean bold, italic, underline, strikeOut;
	CGFloat scaleX, scaleY, spacing, angle;
	Boolean borderStyle;
	CGFloat outline, shadow;
	NSInteger alignment, marginL, marginR, marginV, encoding;
}

@property (copy) NSString *name;
@property (copy) NSString *fontName;
@property (assign) NSInteger fontSize;
@property (assign) ASSColour *primaryColour;
@property (assign) ASSColour *secondaryColour;
@property (assign) ASSColour *outlineColour;
@property (assign) ASSColour *backColour;
@property (assign) Boolean bold;
@property (assign) Boolean italic;
@property (assign) Boolean underline;
@property (assign) Boolean strikeOut;
@property (assign) CGFloat scaleX;
@property (assign) CGFloat scaleY;
@property (assign) CGFloat spacing;
@property (assign) CGFloat angle;
@property (assign) Boolean borderStyle;
@property (assign) CGFloat outline;
@property (assign) CGFloat shadow;
@property (assign) NSInteger alignment;
@property (assign) NSInteger marginL;
@property (assign) NSInteger marginR;
@property (assign) NSInteger marginV;
@property (assign) NSInteger encoding;

- (NSString *) description;
- (void) parseString:(NSString *)aString;
- (id) initWithString:(NSString *)aString; // Designated initializer
- (id) init;

+ (NSString *) beautyfulFloat:(CGFloat)aFloat;

@end
