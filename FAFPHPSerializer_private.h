//
//  FAFPHPSerializer.h
//
//  Created by Manoah F Adams on 2012-10-22.
//  Copyright 2012-2014 Manoah F Adams. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FAFPHPSerializer.h"

@interface FAFPHPSerializer(FAFPHPSerializer_private)

- (NSString*) serializeNumber:(NSNumber*)number;
- (NSString*) serializeString:(NSString*)string;
- (NSString*) serializeArray:(NSArray*)array;
- (NSString*) serializeDictionary:(NSDictionary*)dictionary;

- (NSNumber*) unserializeNumber:(NSScanner*)scanner;
- (NSString*) unserializeString:(NSScanner*)scanner;
- (NSNumber*) unserializeBoolean:(NSScanner*)scanner;
- (id) unserializeArray:(NSScanner*)scanner;

@end
