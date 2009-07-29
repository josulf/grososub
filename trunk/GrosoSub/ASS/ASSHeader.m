//
//  ASSHeader.m
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

#import "ASSHeader.h"

@implementation ASSHeader

@synthesize headerList;
@synthesize order;

- (id) init
{
	if (self = [super init]) {
		headerList = [[NSMutableDictionary alloc] init];
		order = [[NSMutableArray alloc] init];
		[self setValue:@"Default GrosoSub script" forKey:@"Title"];
		[self setValue:@"v4.00+" forKey:@"ScriptType"];
		[self setValue:@"640" forKey:@"PlayResX"];
		[self setValue:@"480" forKey:@"PlayResY"];
	}
	return self;

}

- (NSString *) description
{
	NSString *out = @"";
	
	for (NSString *key in order) {
		out = [out stringByAppendingFormat:@"%@: %@\n", key, [headerList valueForKey:key]];
	}
	
	return out;
}


- (void) setValue:(NSString *)aValue forKey:(NSString *)aKey
{
	// The key isn't on the dictionary, we add it to the array
	if (![[headerList allKeys] containsObject:aKey]) {
		[order addObject:aKey];
	}
	// Now we add or modify the value for key
	[headerList setValue:aValue	forKey:aKey];
}

- (NSString *) getValueForKey:(NSString *)aKey
{
	return [headerList valueForKey:aKey];
}

- (NSUInteger) count
{
	return [headerList count];
}

- (void) delKey:(NSString *)aKey
{
	if ([order containsObject:aKey]) {
		[order removeObject:aKey];
		[headerList removeObjectForKey:aKey];
	}
}

- (void) clean
{
	[headerList removeAllObjects];
	[order removeAllObjects];
}

- (id) initWithString:(NSString *)aString
{
	[self init];
	
	[self parseString:aString];
	
	return self;
}

- (void) parseString:(NSString *)aString
{
	NSArray *lines = [aString componentsSeparatedByString:@"\n"];
	NSString *k, *v;
	
	for (NSString *line in lines) {
		NSScanner *scanner = [NSScanner scannerWithString:line];
		[scanner scanUpToString:@":" intoString:&k]; //scan key
		[scanner scanString:@": " intoString:NULL]; //skip : 
		[scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"] intoString:&v]; //scan value
		
		[self setValue:v forKey:k]; //add to the headerList and order
	}
}

@end
