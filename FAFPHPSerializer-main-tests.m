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

- (void) test_unserializeItem_Array_Within_Array
{
	
	// php -r 'print serialize(Array(Array("Hello", "goodbye"), Array("Hello", "goodbye"), Array("Hello", "goodbye"))) . "\n";'
	
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* items = [NSArray arrayWithObjects:@"Hello", @"goodbye", nil];
	NSArray* result = [phpSerializer unserializeItem:@"a:3:{i:0;a:2:{i:0;s:5:\"Hello\";i:1;s:7:\"goodbye\";}i:1;a:2:{i:0;s:5:\"Hello\";i:1;s:7:\"goodbye\";}i:2;a:2:{i:0;s:5:\"Hello\";i:1;s:7:\"goodbye\";}}"];
	
	//NSLog(@"%@", result);
	
	STAssertTrue(([result count] == 3), @"count: %u", [result count]);
	STAssertEqualObjects(items, [result objectAtIndex:1], nil);
}

- (void) test_unserializeItem_String_With_Quotes
{
	
	
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSString* result = [phpSerializer unserializeItem:@"s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";"];
	
	//NSLog(@"%@", result);
	
	STAssertEqualObjects(@"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}", result, nil);
}

- (void) test_unserializeItem_Array_Keys_as_Strings
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSDictionary* result = [phpSerializer unserializeItem:@"a:14:{s:7:\"entryID\";s:1:\"1\";s:10:\"identifier\";s:0:\"\";s:5:\"title\";s:0:\"\";s:8:\"fileName\";s:31:\"2011-08-25--1624_VG120-0006.jpg\";s:9:\"directory\";s:8:\"photos/1\";s:4:\"resX\";s:4:\"2560\";s:4:\"resY\";s:4:\"1920\";s:11:\"description\";s:6:\"<null>\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:6:\"a:0:{}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}"];
	
	//NSLog(@"%@", result);

	STAssertEqualObjects([result objectForKey:@"fileName"], @"2011-08-25--1624_VG120-0006.jpg", nil);
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

- (void) test_unserializeItem_Large_Array_2
{
	FAFPHPSerializer* phpSerializer = [[[FAFPHPSerializer alloc] init] autorelease];
	
	
	NSArray* result = [phpSerializer unserializeItem:@"a:30:{i:0;a:14:{s:7:\"entryID\";s:1:\"1\";s:10:\"identifier\";s:0:\"\";s:5:\"title\";s:0:\"\";s:8:\"fileName\";s:31:\"2011-08-25--1624_VG120-0006.jpg\";s:9:\"directory\";s:8:\"photos/1\";s:4:\"resX\";s:4:\"2560\";s:4:\"resY\";s:4:\"1920\";s:11:\"description\";s:6:\"<null>\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:6:\"a:0:{}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:1;a:14:{s:7:\"entryID\";s:2:\"19\";s:10:\"identifier\";s:27:\"2011-07-13--1736_VG120-0007\";s:5:\"title\";s:27:\"2011-07-13--1736_VG120-0007\";s:8:\"fileName\";s:0:\"\";s:9:\"directory\";s:0:\"\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:0:\"\";s:8:\"fileType\";s:0:\"\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:2;a:14:{s:7:\"entryID\";s:1:\"9\";s:10:\"identifier\";s:18:\"YoungJohnAdams.jpg\";s:5:\"title\";s:14:\"YoungJohnAdams\";s:8:\"fileName\";s:18:\"YoungJohnAdams.jpg\";s:9:\"directory\";s:8:\"photos/2\";s:4:\"resX\";s:3:\"117\";s:4:\"resY\";s:3:\"164\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:6:\"a:0:{}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"1\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:3;a:14:{s:7:\"entryID\";s:2:\"10\";s:10:\"identifier\";s:18:\"Albion-closeup.png\";s:5:\"title\";s:18:\"Albion-closeup.png\";s:8:\"fileName\";s:18:\"Albion-closeup.png\";s:9:\"directory\";s:8:\"photos/2\";s:4:\"resX\";s:3:\"502\";s:4:\"resY\";s:3:\"617\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"png\";s:11:\"permissions\";s:6:\"a:0:{}\";s:9:\"locations\";s:32:\"a:1:{i:0;s:14:\"front_door.php\";}\";s:9:\"linkCount\";s:1:\"1\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:4;a:14:{s:7:\"entryID\";s:1:\"6\";s:10:\"identifier\";s:13:\"R1-04490-021A\";s:5:\"title\";s:17:\"R1-04490-021A.jpg\";s:8:\"fileName\";s:17:\"R1-04490-021A.jpg\";s:9:\"directory\";s:8:\"photos/1\";s:4:\"resX\";s:4:\"1800\";s:4:\"resY\";s:4:\"1215\";s:11:\"description\";s:0:\"\";s:8:\"fileType\";s:0:\"\";s:11:\"permissions\";s:121:\"a:2:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:3:\"all\";}i:1;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:5;a:14:{s:7:\"entryID\";s:2:\"11\";s:10:\"identifier\";s:27:\"2011-07-25--1131_VG120-0051\";s:5:\"title\";s:31:\"2011-07-25--1131_VG120-0051.jpg\";s:8:\"fileName\";s:31:\"2011-07-25--1131_VG120-0051.jpg\";s:9:\"directory\";s:8:\"photos/1\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:6;a:14:{s:7:\"entryID\";s:2:\"12\";s:10:\"identifier\";s:27:\"2011-07-25--1131_VG120-0052\";s:5:\"title\";s:31:\"2011-07-25--1131_VG120-0052.jpg\";s:8:\"fileName\";s:31:\"2011-07-25--1131_VG120-0052.jpg\";s:9:\"directory\";s:8:\"photos/1\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:7;a:14:{s:7:\"entryID\";s:2:\"13\";s:10:\"identifier\";s:27:\"2012-04-16--1147_VG120-0067\";s:5:\"title\";s:17:\"Church Funigation\";s:8:\"fileName\";s:31:\"2012-04-16--1147_VG120-0067.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:64:\"The idea of fumigating a church seems rather sacreligious to me.\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:8;a:14:{s:7:\"entryID\";s:2:\"36\";s:10:\"identifier\";s:31:\"2011-08-11--2331_VG120-0079-mod\";s:5:\"title\";s:31:\"2011-08-11--2331_VG120-0079-mod\";s:8:\"fileName\";s:35:\"2011-08-11--2331_VG120-0079-mod.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:6:\"a:0:{}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:9;a:14:{s:7:\"entryID\";s:2:\"15\";s:10:\"identifier\";s:0:\"\";s:5:\"title\";s:0:\"\";s:8:\"fileName\";s:31:\"2011-09-07--1700_VG120-0014.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:172:\"I was outside an auto-repair shop, watching the the bikes, and found myself admiring the summer cumulous buildup ... which took less than a half hour for these four photos.\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:10;a:14:{s:7:\"entryID\";s:2:\"16\";s:10:\"identifier\";s:27:\"2011-09-07--1709_VG120-0023\";s:5:\"title\";s:33:\"Summer Cumulous buildup - frame 4\";s:8:\"fileName\";s:0:\"\";s:9:\"directory\";s:0:\"\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:0:\"\";s:8:\"fileType\";s:0:\"\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:11;a:14:{s:7:\"entryID\";s:2:\"17\";s:10:\"identifier\";s:27:\"2011-09-07--1703_VG120-0018\";s:5:\"title\";s:33:\"Summer Cumulous buildup - frame 3\";s:8:\"fileName\";s:31:\"2011-09-07--1703_VG120-0018.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:172:\"I was outside an auto-repair shop, watching the the bikes, and found myself admiring the summer cumulous buildup ... which took less than a half hour for these four photos.\";s:8:\"fileType\";s:0:\"\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:12;a:14:{s:7:\"entryID\";s:2:\"18\";s:10:\"identifier\";s:27:\"2011-09-07--1700_VG120-0016\";s:5:\"title\";s:33:\"Summer Cumulous buildup - frame 2\";s:8:\"fileName\";s:31:\"2011-09-07--1700_VG120-0016.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"983\";s:4:\"resY\";s:3:\"737\";s:11:\"description\";s:172:\"I was outside an auto-repair shop, watching the the bikes, and found myself admiring the summer cumulous buildup ... which took less than a half hour for these four photos.\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:13;a:14:{s:7:\"entryID\";s:2:\"20\";s:10:\"identifier\";s:27:\"2013-02-15--1353_VG120-0003\";s:5:\"title\";s:27:\"2013-02-15--1353_VG120-0003\";s:8:\"fileName\";s:31:\"2013-02-15--1353_VG120-0003.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:57:\"Likewise teaching grammar on these court are prohibited !\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:14;a:14:{s:7:\"entryID\";s:2:\"21\";s:10:\"identifier\";s:27:\"2012-05-06--1832_VG120-0086\";s:5:\"title\";s:27:\"2012-05-06--1832_VG120-0086\";s:8:\"fileName\";s:31:\"2012-05-06--1832_VG120-0086.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:59:\"Buckets of paint used to be 5 gallons ... now 4.75 gallons.\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:15;a:14:{s:7:\"entryID\";s:2:\"22\";s:10:\"identifier\";s:27:\"2012-05-06--1831_VG120-0083\";s:5:\"title\";s:27:\"2012-05-06--1831_VG120-0083\";s:8:\"fileName\";s:31:\"2012-05-06--1831_VG120-0083.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:54:\"Cans of paint used to be 1 gallon ... now 0.9 gallons.\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:16;a:14:{s:7:\"entryID\";s:2:\"23\";s:10:\"identifier\";s:27:\"2012-04-18--1746_VG120-0068\";s:5:\"title\";s:27:\"2012-04-18--1746_VG120-0068\";s:8:\"fileName\";s:31:\"2012-04-18--1746_VG120-0068.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:125:\"This poor bird among the many victims of the islands of trash floating in our oceans (a missing toe due to a tangled string).\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:17;a:14:{s:7:\"entryID\";s:2:\"24\";s:10:\"identifier\";s:27:\"2011-12-20--1752_VG120-0014\";s:5:\"title\";s:27:\"2011-12-20--1752_VG120-0014\";s:8:\"fileName\";s:31:\"2011-12-20--1752_VG120-0014.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:18;a:14:{s:7:\"entryID\";s:2:\"25\";s:10:\"identifier\";s:27:\"2011-11-03--1707_VG120-0029\";s:5:\"title\";s:27:\"2011-11-03--1707_VG120-0029\";s:8:\"fileName\";s:31:\"2011-11-03--1707_VG120-0029.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:69:\"Leave it to the Japanese to have one of the nicest from yards around.\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:19;a:14:{s:7:\"entryID\";s:2:\"26\";s:10:\"identifier\";s:27:\"2011-05-22--1438_VG120-0090\";s:5:\"title\";s:15:\"Sun Halo -color\";s:8:\"fileName\";s:31:\"2011-05-22--1438_VG120-0090.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:20;a:14:{s:7:\"entryID\";s:2:\"27\";s:10:\"identifier\";s:27:\"2011-05-22--1436_VG120-0089\";s:5:\"title\";s:14:\"Sun Halo -gray\";s:8:\"fileName\";s:31:\"2011-05-22--1436_VG120-0089.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:65:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:5:\"Group\";i:2;s:6:\"public\";}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:21;a:14:{s:7:\"entryID\";s:2:\"32\";s:10:\"identifier\";s:0:\"\";s:5:\"title\";s:0:\"\";s:8:\"fileName\";s:31:\"2011-12-16--1140_VG120-0145.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"587\";s:4:\"resY\";s:3:\"440\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:6:\"a:0:{}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:22;a:14:{s:7:\"entryID\";s:2:\"28\";s:10:\"identifier\";s:27:\"2011-09-10--1534_VG120-0040\";s:5:\"title\";s:27:\"2011-09-10--1534_VG120-0040\";s:8:\"fileName\";s:31:\"2011-09-10--1534_VG120-0040.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"983\";s:4:\"resY\";s:3:\"737\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:6:\"a:0:{}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:23;a:14:{s:7:\"entryID\";s:2:\"34\";s:10:\"identifier\";s:27:\"2014-01-31--1851_VG120-0031\";s:5:\"title\";s:27:\"2014-01-31--1851_VG120-0031\";s:8:\"fileName\";s:31:\"2014-01-31--1851_VG120-0031.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"748\";s:4:\"resY\";s:3:\"561\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:6:\"a:0:{}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:24;a:14:{s:7:\"entryID\";s:2:\"35\";s:10:\"identifier\";s:27:\"2011-08-13--2143_VG120-0094\";s:5:\"title\";s:27:\"2011-08-13--2143_VG120-0094\";s:8:\"fileName\";s:31:\"2011-08-13--2143_VG120-0094.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"248\";s:4:\"resY\";s:3:\"168\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:6:\"a:0:{}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:25;a:14:{s:7:\"entryID\";s:2:\"44\";s:10:\"identifier\";s:0:\"\";s:5:\"title\";s:0:\"\";s:8:\"fileName\";s:27:\"trv2-storage-move-out-6.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"237\";s:4:\"resY\";s:3:\"244\";s:11:\"description\";s:0:\"\";s:8:\"fileType\";s:0:\"\";s:11:\"permissions\";s:55:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:4:\"User\";i:2;i:1;}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:26;a:14:{s:7:\"entryID\";s:2:\"43\";s:10:\"identifier\";s:23:\"trv2-storage-move-out-4\";s:5:\"title\";s:23:\"trv2-storage-move-out-4\";s:8:\"fileName\";s:0:\"\";s:9:\"directory\";s:0:\"\";s:4:\"resX\";s:3:\"236\";s:4:\"resY\";s:3:\"238\";s:11:\"description\";s:0:\"\";s:8:\"fileType\";s:0:\"\";s:11:\"permissions\";s:55:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:4:\"User\";i:2;i:1;}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:27;a:14:{s:7:\"entryID\";s:2:\"40\";s:10:\"identifier\";s:23:\"trv2-storage-move-out-3\";s:5:\"title\";s:23:\"trv2-storage-move-out-3\";s:8:\"fileName\";s:27:\"trv2-storage-move-out-3.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"230\";s:4:\"resY\";s:3:\"239\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:55:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:4:\"User\";i:2;i:1;}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:28;a:14:{s:7:\"entryID\";s:2:\"41\";s:10:\"identifier\";s:23:\"trv2-storage-move-out-2\";s:5:\"title\";s:23:\"trv2-storage-move-out-2\";s:8:\"fileName\";s:27:\"trv2-storage-move-out-2.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"231\";s:4:\"resY\";s:3:\"239\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:55:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:4:\"User\";i:2;i:1;}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}i:29;a:14:{s:7:\"entryID\";s:2:\"42\";s:10:\"identifier\";s:23:\"trv2-storage-move-out-1\";s:5:\"title\";s:23:\"trv2-storage-move-out-1\";s:8:\"fileName\";s:27:\"trv2-storage-move-out-1.jpg\";s:9:\"directory\";s:8:\"photos/4\";s:4:\"resX\";s:3:\"235\";s:4:\"resY\";s:3:\"237\";s:11:\"description\";s:3:\"---\";s:8:\"fileType\";s:3:\"jpg\";s:11:\"permissions\";s:55:\"a:1:{i:0;a:3:{i:0;s:5:\"Allow\";i:1;s:4:\"User\";i:2;i:1;}}\";s:9:\"locations\";s:6:\"a:0:{}\";s:9:\"linkCount\";s:1:\"0\";s:7:\"primary\";s:1:\"1\";s:10:\"alternates\";s:6:\"a:0:{}\";}}"];
	
	STAssertTrue(([result count] == 30), @"count: %u", [result count]);
	STAssertEqualObjects(@"2011-05-22--1436_VG120-0089.jpg", [[result objectAtIndex:20] objectForKey:@"fileName"], nil);
	//NSLog(@"%@", result);
}

@end
