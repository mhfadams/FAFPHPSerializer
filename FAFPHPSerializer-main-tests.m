//
//  FAFPHPSerializer-main-tests.m
//  FAFPHPSerializerTester
//
//  Created by Manoah F Adams on 2014-05-08.
//  Copyright 2014 Manoah F. Adams. All rights reserved.
//

#import "FAFPHPSerializer-main-tests.h"
#import "FAFPHPSerializer.h"

@implementation FAFPHPSerializer_main_tests


- (void) test_serializeItem_NSArray
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	NSArray* items = [NSArray arrayWithObjects:@"happy", [NSNumber numberWithInt:6], @"sad", nil];
	
	NSString* result = [phpSerializer serializeItem:items];
	
	STAssertEqualObjects(@"a:3:{i:0;s:5:\"happy\";i:1;i:6;i:2;s:3:\"sad\";}", result, nil);
}

- (void) test_unserializeItem_Array
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSString* items = [NSArray arrayWithObjects:@"happy", [NSNumber numberWithInt:6], @"sad", nil];
	NSArray* result = [phpSerializer unserializeItem:@"a:3:{i:0;s:5:\"happy\";i:1;i:6;i:2;s:3:\"sad\";}"];
	
	STAssertEqualObjects(items, result, nil);
}

- (void) test_PHP_source_Array
{
	FAFPHPSerializer* serializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* array = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"Allow", @"Group", @"all", nil], [NSArray arrayWithObjects:@"Deny", @"User", @"mhfadams", nil], nil];
	NSString* result = [serializer phpSourceForArray:array];
	
	STAssertEqualObjects(@"Array(Array('Allow', 'Group', 'all'), Array('Deny', 'User', 'mhfadams'))", result, nil);
}

@end
