//
//  FAFPHPSerializer.h
//
//  Created by Manoah F Adams on 2012-10-22.
//  Copyright 2012-2014 Manoah F Adams. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FAFPHPSerializer : NSObject
{
	BOOL	_shouldAutoGuessEmptyStrings;
}

/*!
\brief	Should the library assume that a string with a positive length, but appearing to be empty, is empty.
		Any string being unserialized in the format s:6:"" will be considered empty.
		Default is NO (off).
*/
- (BOOL)shouldAutoGuessEmptyStrings;
- (void)setShouldAutoGuessEmptyStrings:(BOOL)value;


/*!
\brief	Convert an NSArray, NSDictionary, NSNumber, or NSString to a string that can be read with PHP's unserialize().
*/
- (NSString*) serializeItem:(id)item;

/*!
\brief	Convert a string created by PHP's serialize() function into the corresponding NSArray, NSDictionary, NSNumber, or NSString.
 */
- (id) unserializeItem:(NSString*)item;


/*!
\brief	Returns a string of PHP source code that would produce the equivalent of the input NSArray.
 
 This method is tentative, and not used much currently.
 */
- (NSString*) phpSourceForArray:(NSArray*)array;

@end
