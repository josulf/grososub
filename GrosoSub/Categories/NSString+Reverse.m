//
//  NSString+Reverse.m
//  GrosoSub
//
//  Created by Josu López Fernández on 11/08/09.
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

#import "NSString+Reverse.h"


@implementation NSString (reverse)

-(NSString *) reverseString
{
	NSMutableString *rev;
	int len = [self length];
	int i;
	
	rev = [NSMutableString stringWithCapacity:len];     
	
	for (i = len-1; i >= 0; i--) {
		[rev appendFormat:@"%c", [self characterAtIndex:i]];
	}
	
	return rev;
}
@end
