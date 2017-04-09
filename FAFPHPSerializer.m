//
//  FAFPHPSerializer.m
//
//  Created by Manoah F Adams on 2012-10-22.
//  Copyright 2012-2014 Manoah F. Adams . All rights reserved.
//

#import "FAFPHPSerializer_private.h"
#import "FAFPHPSerializer.h"

#ifdef IN_TEST_UNIT
	#import "FAFStringScanner.h"
#else
	#import <FAFFoundationExtensions/FAFStringScanner.h>
#endif

@implementation FAFPHPSerializer

- (BOOL)shouldAutoGuessEmptyStrings {
    return _shouldAutoGuessEmptyStrings;
}

- (void)setShouldAutoGuessEmptyStrings:(BOOL)value {
    if (_shouldAutoGuessEmptyStrings != value) {
        _shouldAutoGuessEmptyStrings = value;
    }
}


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
	
	//NSScanner* scanner = [[[NSScanner alloc] initWithString:item] retain];
	FAFStringScanner* scanner = [[[FAFStringScanner alloc] initWithString:item] autorelease];
	//[scanner setCharactersToBeSkipped:[NSSet set]];
	
	NSString* string;
	
	
	id output = @"";
	while ( ! [scanner isAtEnd] )
	{
		string  = [scanner readUntilStringAdvancingPast:@":"];
		
		if ([string isEqualToString:@"a"]) {
			output = [self unserializeArray:scanner];
		} else if ([string isEqualToString:@"s"]) {
			output = [self unserializeString:scanner];
		} else if ([string isEqualToString:@"i"]) {
			output = [self unserializeNumber:scanner];
		} else if ([string isEqualToString:@"b"]) {
			output = [self unserializeBoolean:scanner];
		}
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

- (NSNumber*) unserializeNumber:(FAFStringScanner*)scanner {
	NSString* string;
	string = [scanner readUntilStringAdvancingPast:@";"];
	//NSLog(@"unserializeNumber: %@", string);
	return [NSNumber numberWithInt:[string intValue]];
}

- (NSString*) unserializeString:(FAFStringScanner*)scanner {
	NSString* len;
	len = [scanner readUntilStringAdvancingPast:@":"];
	int stringLength = [len intValue];
	//NSLog(@"stringLength = %d", stringLength);
	NSString* string;
	
	if (stringLength == 0)
	{
		(void)[scanner readUntilStringAdvancingPast:@";"]; // skip closing semi-colon
		return @"";
	}
	else
	{
		[scanner advance:1]; // past opening quote
		string = [scanner readForLengthAdvancing:stringLength];
		if ( ([string length] == 0) || (([string length] > 2) && [[string substringToIndex:2] isEqual:@"\";"]) )
		{
			if (_shouldAutoGuessEmptyStrings)
			{
				[scanner advance:((-1) * [string length])];
				string = @"";
			}
			else
				fprintf(stderr, [@"FAFPHPSerializer: Warning: string appears to be improperly counted. Output may be garbled.\n" cStringUsingEncoding:NSUTF8StringEncoding]);
		}
		[scanner advance:2]; // past closing quote and semicolon
	}
	//NSLog(@"unserializeString: %@", string);

	return string;
}

- (NSNumber*) unserializeBoolean:(FAFStringScanner*)scanner {
	NSString* string;
	string = [scanner readUntilStringAdvancingPast:@";"];
	//NSLog(@"unserializeBoolean: %@", string);
	return [NSNumber numberWithInt:[string intValue]];
}

- (id) unserializeArray:(FAFStringScanner*)scanner {
	
	// This will return a NSArray or NSDictionary
	// ... because PHP uses the same class for both arrays and dictionaries
	// ... if all keys are numbers and in sequence then return as array
	
	// while converting we create both array and dict since we dont know which kind we will need
	
	NSString* string;
	
	string  = [scanner readUntilStringAdvancingPast:@":"];
	int arrayCount = [string intValue];
	string = @"";
	

	[scanner readUntilStringAdvancingPast:@"{"];

	NSMutableDictionary* output = [NSMutableDictionary new];
	NSMutableArray* items = [NSMutableArray new];
	if ( arrayCount == 0 )
		return items;
	id key = nil;
	id value = @"";
	BOOL isArray = YES;
	int idx = -1; // for isArray check
	
	for (int i = 0; i < arrayCount; i++)
	{
		
		if ([scanner isAtEnd])
			break;
		
		// get the key
		string = [scanner readUntilStringAdvancingPast:@":"];
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
	
		NSString* matchedString;
		string  = [scanner readUntilStringsAdvancingPast:[NSArray arrayWithObjects:@":", @";", nil] matchString:&matchedString];
		// get the value
		if ([string isEqualToString:@"a"]) {
			value = [self unserializeArray:scanner];
		} else if ([string isEqualToString:@"s"]) {
			value = [self unserializeString:scanner];
		} else if ([string isEqualToString:@"i"]) {
			value = [self unserializeNumber:scanner];
		} else if ([string isEqualToString:@"b"]) {
			value = [self unserializeBoolean:scanner];
		} else {
			;
		}
		//NSLog(@"value = %@", value);
		//NSLog(@"key = %@", key);
		
		//if ( value )
			[output setObject:value forKey:key];

		
		[items addObject:value];
		
	}	
	[scanner readUntilStringAdvancingPast:@"}"]; // skip closing brace
	
	
	
	if (isArray)
	{
		return items; // return array form
	}
	else
	{
		//[output allValues];
	}
	
	return output; // return dictionary form
	
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
