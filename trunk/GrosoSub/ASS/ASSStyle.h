//
//  ASSStyle.h
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright (C) 2009 Josu López Fernández <fregona@fregona.biz>.
//	All rights reserved.
//
//	This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; only version 2 of the License.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License along
//	with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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

- (NSColor *) primaryNSColor;
- (NSColor *) secondaryNSColor;
- (NSColor *) outlineNSColor;
- (NSColor *) backNSColor;

+ (NSString *) beautyfulFloat:(CGFloat)aFloat;

@end
