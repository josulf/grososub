//
//  ASSEvent.h
//  GrosoSub
//
//  Created by Josu López Fernández on 14/07/09.
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

@class ASSTime;

@interface ASSEvent : NSObject <NSCopying> {
	Boolean dialogue;
	NSInteger layer;
	ASSTime *start, *end, *duration;;
	NSString *style, *name;
	NSInteger marginL, marginR, marginV;
	NSString *effect, *text;
}

@property (assign) Boolean dialogue;
@property (assign) NSInteger layer;
@property (retain) ASSTime *start;
@property (retain) ASSTime *end;
@property (retain) ASSTime *duration;
@property (copy) NSString *style;
@property (copy) NSString *name;
@property (assign) NSInteger marginL;
@property (assign) NSInteger marginR;
@property (assign) NSInteger marginV;
@property (copy) NSString *effect;
@property (copy) NSString *text;

- (NSString *) description;
- (NSString *) descriptionSRT;

- (void) parseString:(NSString *)aString;
- (id) initWithString:(NSString *)aString; // Designated initializer
- (id) init;

- (void) joinWithEvent:(ASSEvent *)aEvent;

@end
