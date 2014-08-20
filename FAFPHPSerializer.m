//
//  FAFPHPSerializer.m
//
//  Created by Manoah F Adams on 2012-10-22.
//  Copyright 2012-2014 Manoah F. Adams . All rights reserved.
//

#import "FAFPHPSerializer_private.h"
#import "FAFPHPSerializer.h"


@implementation FAFPHPSerializer

- (NSString*) serializeItem:(id)item {
	if ( (!item) || (item == NULL) || [item isKindOfClass:[NSNull class]]) return [self serializeArray:[NSArray new]];
	//NSLog(@"-[PHPSerializer serializeItem:%@]", item);
	[item retain];
	NSString* output = @"";

	if ([item isKindOfClass:[NSNumber class]]) {
		output = [output stringByAppendingString:[self serializeNumber:item]];
	} else if ([item isKindOfClass:[NSString class]]) {
		output = [output stringByAppendingString:[self serializeString:item]];
	} else if ([item isKindOfClass:[NSArray class]]) {
		output = [output stringByAppendingString:[self serializeArray:item]];
	} else if ([item isKindOfClass:[NSDictionary class]]) {
		output = [output stringByAppendingString:[self serializeDictionary:item]];
	}
	[item release];
	return output;
}

- (id) unserializeItem:(NSString*)item {
	
	if ( (!item) || (item == NULL) || [item isKindOfClass:[NSNull class]]) return nil;
	//NSLog(@"[PHPSerializer unserializeItem:%@]", item);
	
	NSScanner* scanner = [[[NSScanner alloc] initWithString:item] retain];
	
	//[scanner setCharactersToBeSkipped:[NSSet set]];
	
	NSString* string;
	
	
	id output;
	while ([scanner isAtEnd] == NO) {
		[scanner scanUpToString:@":" intoString:&string];
		//[scanner setScanLocation:([scanner scanLocation] + 1)];
		
		//NSLog(string);
		if ([string isEqualToString:@"a"]) {
			output = [self unserializeArray:scanner];
		} else if ([string isEqualToString:@"s"]) {
			output = [self unserializeString:scanner];
		} else if ([string isEqualToString:@"i"]) {
			output = [self unserializeNumber:scanner];
		} else if ([string isEqualToString:@"b"]) {
			output = [self unserializeBoolean:scanner];
		}
		string = @"";
	}	
	
	return output;
	
}


- (NSString*) serializeNumber:(NSNumber*)number {
	//NSLog(@"[PHPSerializer serializeNumber]");
	return [NSString stringWithFormat:@"i:%d;", [number intValue]];
}

- (NSString*) serializeString:(NSString*)string {
	//NSLog(@"[PHPSerializer serializeString]");
	return [NSString stringWithFormat:@"s:%d:\"%@\";", [string length], string];
}

- (NSString*) serializeArray:(NSArray*)array {
	//NSLog(@"[PHPSerializer serializeArray]");
	NSEnumerator* enumerator = [array objectEnumerator];
	id item;
	
	NSString* output = [NSString stringWithFormat:@"a:%d:{", [array count]];
	
	
	// note that an array cannot hold a bool, only number
	// ... and we cant know the programmer's indended use
	// ... so always treat as number
	while (item = [enumerator nextObject]) {
		output = [output stringByAppendingString:[NSString stringWithFormat:@"i:%d;", [array indexOfObject:item]]];
		if ([item isKindOfClass:[NSNumber class]]) {
			output = [output stringByAppendingString:[self serializeNumber:item]];
		} else if ([item isKindOfClass:[NSString class]]) {
			output = [output stringByAppendingString:[self serializeString:item]];
		} else if ([item isKindOfClass:[NSArray class]]) {
			output = [output stringByAppendingString:[self serializeArray:item]];
		} else if ([item isKindOfClass:[NSDictionary class]]) {
			output = [output stringByAppendingString:[self serializeDictionary:item]];
		}
	}
	
	return [output stringByAppendingString:@"}"];
	
}

- (NSString*) serializeDictionary:(NSDictionary*)dictionary {
	//NSLog(@"[PHPSerializer serializeDictionary]");
	NSArray* keys = [[dictionary allKeys] retain];
	NSEnumerator* enumerator = [keys objectEnumerator];
	NSString* key;
	
	NSString* output = [NSString stringWithFormat:@"a:%d:{", [keys count]];
	
	
	// note that an array cannot hold a bool, only number
	// ... and we cant know the programmer's indended use
	// ... so always treat as number
	while (key = [enumerator nextObject]) {
		output = [output stringByAppendingString:[NSString stringWithFormat:@"s:%d:\"%@\";", [key length], key]];
		if ([[dictionary objectForKey:key] isKindOfClass:[NSNumber class]]) {
			output = [output stringByAppendingString:[self serializeNumber:[dictionary objectForKey:key]]];
		} else if ([[dictionary objectForKey:key] isKindOfClass:[NSString class]]) {
			output = [output stringByAppendingString:[self serializeString:[dictionary objectForKey:key]]];
		} else if ([[dictionary objectForKey:key] isKindOfClass:[NSArray class]]) {
			output = [output stringByAppendingString:[self serializeArray:[dictionary objectForKey:key]]];
		} else if ([[dictionary objectForKey:key] isKindOfClass:[NSDictionary class]]) {
			output = [output stringByAppendingString:[self serializeDictionary:[dictionary objectForKey:key]]];
		}
	}
	
	return [output stringByAppendingString:@"}"];
	
}

- (NSNumber*) unserializeNumber:(NSScanner*)scanner {
	NSString* string;
	[scanner setScanLocation:([scanner scanLocation] + 1)];
	[scanner scanUpToString:@";" intoString:&string];
	[scanner setScanLocation:([scanner scanLocation] + 1)];
	return [NSNumber numberWithInt:[string intValue]];
}

- (NSString*) unserializeString:(NSScanner*)scanner {
	NSString* len;
	[scanner setScanLocation:([scanner scanLocation] + 1)];
	[scanner scanUpToString:@":" intoString:&len];
	int stringLength = [len intValue];
	//NSLog(@"stringLength = %d", stringLength);
	
	NSString* string = @"";
	[scanner scanUpToString:@"\"" intoString:NULL]; // skip opening quote
	[scanner setScanLocation:([scanner scanLocation] + 1)];
	// although we know the length of the string,
	// ... NSScanner doesn't let us scanForLength, so a workaround/
	// ... seems the simplest to me to do the following
	while ([string length] < stringLength) {
		[scanner scanUpToString:@"\"" intoString:&string];
		//[scanner setScanLocation:([scanner scanLocation] + 1)];
	}

	[scanner scanUpToString:@";" intoString:NULL]; // skip closing semi-colon
	[scanner setScanLocation:([scanner scanLocation] + 1)];

	return string;
}

- (NSNumber*) unserializeBoolean:(NSScanner*)scanner {
	NSString* string;
	[scanner setScanLocation:([scanner scanLocation] + 1)];
	[scanner scanUpToString:@";" intoString:&string];
	[scanner setScanLocation:([scanner scanLocation] + 1)];
	return [NSNumber numberWithInt:[string intValue]];
}

- (id) unserializeArray:(NSScanner*)scanner {
	
	// This will return a NSArray or NSDictionary
	// ... because PHP uses the same class for both arrays and dictionaries
	// ... if all keys are numbers and in sequence then return as array
	
	NSString* string;
	
	[scanner setScanLocation:([scanner scanLocation] + 1)];
	[scanner scanUpToString:@":" intoString:&string];
	[scanner setScanLocation:([scanner scanLocation] + 1)];
	int arrayCount = [string intValue];
	string = @"";
	

	[scanner scanUpToString:@"{" intoString:NULL];
	[scanner setScanLocation:([scanner scanLocation] + 1)];

	NSMutableDictionary* output = [NSMutableDictionary new];
	NSMutableArray* items = [NSMutableArray new];
	if (arrayCount == 0) return output;
	id key;
	id value;
	BOOL isArray = YES;
	int idx = -1; // for isArray check
	BOOL shouldStop = NO;
	
	while (! shouldStop ) {
		
		// unfortunately NSScanner doesnt have a nextChar, so workaround
		int loc1 = [scanner scanLocation];
		[scanner scanUpToString:@"}" intoString:NULL];
		int loc2 = [scanner scanLocation];
		if (loc1 >= loc2) {
			shouldStop = YES;
		}
		[scanner setScanLocation:loc1];
		//[scanner setScanLocation:([scanner scanLocation] - 2)];
		if ([scanner isAtEnd]) {
			shouldStop = YES;
		}
		if (! shouldStop) {
			
			// get the key
			[scanner scanUpToString:@":" intoString:&string];
			if ([string isEqualToString:@"s"]) {
				key = [self unserializeString:scanner];
			} else if ([string isEqualToString:@"i"]) {
				key = [self unserializeNumber:scanner];
			} else {
				key = string;
			}
			if ( ! ([key isKindOfClass:[NSNumber class]]) ) {
				isArray = NO;  // index not a number
				//NSLog(@"index not a number");
			} else {
				if ([key intValue] > idx) {
					idx = idx + 1;
				} else {
					isArray = NO; // indexes not sequential
					//NSLog(@"indexes not sequential");
				}
			}
			//NSLog(@"key = %@", key);
			//if (!isArray) NSLog(@"not an Array");
			
			
			string = @"";
		
			[scanner scanUpToString:@":" intoString:&string];
			//[scanner setScanLocation:([scanner scanLocation] - 2)];
			// get the value
			if ([string isEqualToString:@"a"]) {
				value = [self unserializeArray:scanner];
			} else if ([string isEqualToString:@"s"]) {
				value = [self unserializeString:scanner];
			} else if ([string isEqualToString:@"i"]) {
				value = [self unserializeNumber:scanner];
			} else if ([string isEqualToString:@"b"]) {
				value = [self unserializeBoolean:scanner];
			}
			//NSLog(@"value = %@", value);
			
			[output setObject:value forKey:key];
			[items addObject:value];
		}
		
	}	
	//[scanner scanUpToString:@"}" intoString:NULL]; // skip closing brace
	[scanner setScanLocation:([scanner scanLocation] + 1)];
	
	
	
	if (isArray)
	{
		return items;
	}
	else
	{
		[output allValues];
	}
	
	return output;
	
}


- (NSString*) phpSourceForArray:(NSArray*)array {
	// example output: Array(Array('allow', 'group', 'all')))
	[array retain];
	NSLog(@"phpSourceForArray: is under active development and will be superceeded. For testing and provisional uses only.");
	NSMutableArray* output = [NSMutableArray new];
	[output addObject:@"Array("];

	NSEnumerator* enumerator = [array objectEnumerator];
	id item;
	int count = 0;
	while (item = [enumerator nextObject]) {
		if (count > 0) {
			[output addObject:@", "];
		}
		count++;
		if ([item isKindOfClass:[NSArray class]]) {
			[output addObject:[self phpSourceForArray:item]];
		} else if ([item isKindOfClass:[NSString class]]) {
			[output addObject:[NSString stringWithFormat:@"'%@'", item]];
		} else if ([item isKindOfClass:[NSNumber class]]) {
			[output addObject:[item stringValue]];
		} else {
			count--;
		}
	}
	
	[output addObject:@")"];
	[array release];
	return [output componentsJoinedByString:@""];
}






@end
