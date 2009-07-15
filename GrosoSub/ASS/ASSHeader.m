//
//  ASSHeader.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSHeader.h"


@implementation ASSHeader

@synthesize headerList;

- (id) init
{
	if (self = [super init]) {
		headerList = [[NSMutableDictionary alloc] init];
		[headerList setValue:@"Default GrosoSub script" forKey:@"Title"];
		[headerList setValue:@"v4.00+" forKey:@"ScriptType"];
		[headerList setValue:@"640" forKey:@"PlayResX"];
		[headerList setValue:@"480" forKey:@"PlayResY"];
	}
	return self;

}

- (NSString *) description
{
	NSString *out = @"";
	NSArray *keys = [headerList allKeys];
	
	for (NSString *key in keys) {
		out = [out stringByAppendingFormat:@"%@: %@\n", key, [headerList valueForKey:key]];
	}
	
	return out;
}


- (void) setValue:(NSString *)aValue forKey:(NSString *)aKey
{
	[headerList setValue:aValue forKey:aKey];
}

- (NSString *) getValueForKey:(NSString *)aKey
{
	return [headerList valueForKey:aKey];
}

- (NSUInteger) count
{
	return [headerList count];
}

- (void) clean
{
	[headerList removeAllObjects];
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
		
		[headerList setValue:v forKey:k]; //add to the headerList
	}
}

@end
