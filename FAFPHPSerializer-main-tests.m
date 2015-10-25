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

- (void) test_unserializeItem_Array_1
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* items = [NSArray arrayWithObjects:@"happy", [NSNumber numberWithInt:6], @"sad", nil];
	NSArray* result = [phpSerializer unserializeItem:@"a:3:{i:0;s:5:\"happy\";i:1;i:6;i:2;s:3:\"sad\";}"];
	
	STAssertEqualObjects(items, result, nil);
}

- (void) test_unserializeItem_Array_2
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* items = [NSArray arrayWithObjects:@"Allow", @"Group", @"all", nil];
	NSArray* result = [phpSerializer unserializeItem:@"a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}"];
	
	STAssertEqualObjects(items, result, nil);
}

- (void) test_unserializeItem_Null
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* items = [NSArray arrayWithObjects:@"", @"Group", @"all", nil];
	NSArray* result = [phpSerializer unserializeItem:@"a:3:{i:0;N;i:1;s:5:\"Group\";i:2;s:3:\"all\";}"];
	
	STAssertEqualObjects(items, result, nil);
}


- (void) test_unserializeItem_Large_Array
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* items = [NSArray arrayWithObjects:@"Allow", @"Group", @"all", nil];
	NSArray* result = [phpSerializer unserializeItem:@"a:50:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:1;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:2;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:3;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:4;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:5;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:6;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:7;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:8;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:9;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:10;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:11;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:12;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:13;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:14;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:15;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:16;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:17;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:18;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:19;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:20;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:21;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:22;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:23;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:24;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:25;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:26;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:27;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:28;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:29;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:30;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:31;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:32;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:33;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:34;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:35;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:36;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:37;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:38;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:39;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:40;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:41;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:42;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:43;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:44;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:45;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:46;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:47;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:48;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:49;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}}"];
	
	STAssertTrue(([result count] == 50), @"count: %u", [result count]);
	STAssertEqualObjects(items, [result objectAtIndex:20], nil);
}

- (void) test_unserializeItem_Empty_Array
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* result = [phpSerializer unserializeItem:@"a:0:{}"];
	
	STAssertEqualObjects([NSArray new], result, nil);
}

- (void) test_unserializeItem_Empty_String
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* result = [phpSerializer unserializeItem:@"s:0:\"\""];
	
	STAssertEqualObjects(@"", result, nil);
}

- (void) test_PHP_source_Array
{
	FAFPHPSerializer* serializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* array = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"Allow", @"Group", @"all", nil], [NSArray arrayWithObjects:@"Deny", @"User", @"mhfadams", nil], nil];
	NSString* result = [serializer phpSourceForArray:array];
	
	STAssertEqualObjects(@"Array(Array('Allow', 'Group', 'all'), Array('Deny', 'User', 'mhfadams'))", result, nil);
}

@end
