//
//  MyDocument.h
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

#import "ASS/ASSHeader.h"
#import "ASS/ASSStyleList.h"
#import "ASS/ASSEventList.h"

#import "ASSEventTableView.h"

#import "ASSScriptController.h"
#import "ASSStylesController.h"
#import "ASSHeadersController.h"

@interface ASSScript : NSDocument
{
	NSString *name;
	ASSHeader *headers;
	ASSStyleList *styles;
	ASSEventList *events;
	ASSScriptController *scC;
	ASSStylesController *stC;
	ASSHeadersController *heC;
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

- (NSUInteger)countEvents;
- (NSUInteger)countHeaders;
- (NSMutableArray *)actorNames;
- (NSMutableArray *)styleNames;

- (IBAction)showStylesManager:(void *)sender;
- (IBAction)showHeadersManager:(void *)sender;

@property (copy) NSString *name;
@property (retain) ASSHeader *headers;
@property (retain) ASSStyleList *styles;
@property (retain) ASSEventList *events;

@end
