//
//  ASSScript.h
//  GrosoSub
//
//  Created by Josu López Fernández on 19/11/08.
//  Copyright (C) 2008 Josu López Fernández <fregona@fregona.biz>.
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
@class ASSHeader;
@class ASSEvent;
@class ASSStyleList;
@class ASSEventList;
@class ASSStyle;

@interface ASSScript : NSDocument
{
	NSString *name;
	ASSHeader *headers;
	ASSStyleList *styles;
	ASSEventList *events;
}

- (void)addDefaultEventAtIndex:(NSUInteger)aIndex;
- (void)delEventAtIndex:(NSUInteger)aIndex;
- (void)addEvent:(ASSEvent *)aEvent atIndex:(NSUInteger)aIndex;
- (void)dupplicateEventAtIndex:(NSUInteger)aIndex;
- (void)joinEventAtIndex:(NSUInteger)aIndex withEventAtIndex:(NSUInteger)bIndex;
- (void)splitEventAtIndex:(NSUInteger)aIndex withEvent:(ASSEvent *)aEvent and:(ASSEvent *)bEvent;
- (void)replaceEventAtIndex:(NSUInteger)aIndex withEvent:(ASSEvent *)aEvent;

- (ASSEvent *)getEventAtIndex:(NSUInteger)aIndex;

- (NSString *)getHeader:(NSString *)key;
- (void)setValue:(NSString *)value forHeader:(NSString *)key;
- (void)delKey:(NSString *)key;

- (ASSStyle *)getStyleAtIndex:(NSUInteger)aIndex;
- (void)replaceStyleAtIndex:(NSUInteger)aIndex withStyle:(ASSStyle *)aStyle;
- (int)createStyle;
- (void)deleteStyleAtIndex:(NSUInteger)aIndex;
- (int)addStyle:(ASSStyle *)aStyle;
- (int)dupplicateStyleAtIndex:(NSUInteger)aIndex;

- (NSUInteger)countEvents;
- (NSUInteger)countHeaders;
- (NSUInteger)countStyles;
- (NSMutableArray *)actorNames;
- (NSMutableArray *)styleNames;

- (IBAction)showStylesManager:(void *)sender;
- (IBAction)showHeadersManager:(void *)sender;
- (IBAction)showTranslationAssistant:(void *) sender;
- (IBAction)showStylingAssistant:(void *) sender;
- (IBAction)showShiftTimes:(void *) sender;

- (void)shiftTimes:(NSUInteger)direction affectedRows:(NSIndexSet *)rows affectedTimes:(NSUInteger)times time:(NSUInteger)time;

enum ASSDirection {
	ASSBackward = 0,
	ASSForward = 1
};

enum ASSRows {
	ASSAllRows = 0,
	ASSSelectedRows = 1,
	ASSOnwardRows = 2
};

enum ASSTimes {
	ASSAllTimes = 0,
	ASSStartTimes = 1,
	ASSEndTimes = 2
};

@property (copy) NSString *name;
@property (retain) ASSHeader *headers;
@property (retain) ASSStyleList *styles;
@property (retain) ASSEventList *events;

@end
