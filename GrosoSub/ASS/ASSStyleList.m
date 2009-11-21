//
//  ASSStyleList.m
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

#import "ASSStyleList.h"
#import "ASSStyle.h"

@implementation ASSStyleList

@synthesize styles;
@synthesize styleNames;

- (void) addStyleWithName:(NSString *)name
{
	NSString *style = [NSString stringWithFormat:
					   @"Style: %@,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,0,0,0,0,100.00,100.00,0.00,0.00,1,2.00,2.00,2,10,10,10,0",
					   name];
	[self addStyleFromString:style];
	
}

- (void) addStyleFromString:(NSString *)aString
{
	[styles addObject:[[ASSStyle alloc] initWithString:aString]];
	[styleNames addObject:[[styles lastObject] name]];
	[styleNames sortUsingSelector:@selector(compare:)];
}

- (void) addStyleFromString:(NSString *)aString atIndex:(NSUInteger)index
{
	[styles insertObject:[[ASSStyle alloc] initWithString:aString] atIndex:index];
	[styleNames addObject:[[styles objectAtIndex:index] name]];
	[styleNames sortUsingSelector:@selector(compare:)];
}

- (void) changeStyleFromString:(NSString *)aString atIndex:(NSUInteger)index
{
	// Index of the name
	NSUInteger aIndex = index;
	// Index of the style
	NSUInteger rIndex = [self indexOfStyle:[styleNames objectAtIndex:aIndex]];
	
	[styleNames removeObjectAtIndex:aIndex];
	[styles replaceObjectAtIndex:rIndex withObject:[[ASSStyle alloc] initWithString:aString]];
	[styleNames addObject:[[styles objectAtIndex:rIndex] name]];
	[styleNames sortUsingSelector:@selector(compare:)];
}

- (void) delStyleAtIndex:(NSUInteger)index
{
	// Index of the name
	NSUInteger aIndex = index;
	// Index of the style
	NSUInteger rIndex = [self indexOfStyle:[styleNames objectAtIndex:aIndex]];
	
	[styleNames removeObjectAtIndex:aIndex];
	[styles removeObjectAtIndex:rIndex];
}

- (ASSStyle *) getStyleAtIndex:(NSUInteger)index
{
	// create a new style with the name we want to fetch
	ASSStyle *new = [[ASSStyle alloc] init];
	[new setName:[styleNames objectAtIndex:index]];
	// get the index of that name into the array
	NSUInteger id = [styles indexOfObject:new];
	return [styles objectAtIndex:id];
}

- (NSUInteger) indexOfStyle:(NSString *)name
{
	ASSStyle *new = [[ASSStyle alloc] init];
	[new setName:name];
	return [styles indexOfObject:new];
}

- (NSUInteger) indexOfStyleName:(NSString *)name
{
	return [styleNames indexOfObject:name];
}

- (NSUInteger) countStyles
{
	return [styles count];
}

- (void) clean
{
	[styles removeAllObjects];
	[styleNames removeAllObjects];
}

- (void) parseString:(NSString *)aString
{
	NSArray *lines = [aString componentsSeparatedByString:@"\n"];
	for (NSString *style in lines) {
		if (([style length] > 0) & ![style isEqualToString:@"\r"]) {
			NSScanner *scanner = [NSScanner scannerWithString:style];
			NSString *aux;
			[scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"] intoString:&aux];
			[self addStyleFromString:aux];
		}
	}
}

- (id) initWithString:(NSString *)aString
{
	if (self = [super init]) {
		styles = [[NSMutableArray alloc] init];
		styleNames = [[NSMutableArray alloc] init];
		
		[self parseString:aString];
	}
	return self;
}

- (id) init
{
	[self initWithString:@"Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,0,0,0,0,100.00,100.00,0.00,0.00,1,2.00,2.00,2,10,10,10,0"];
	return self;
}

- (NSString *) description
{
	NSString *out = [[NSString alloc] init];
	
	for (ASSStyle *style in styles) {
		
		out = [out stringByAppendingFormat:@"%@\n", [style description]];
	}
	
	return out;
}

@end
