//
//  MK61Logger.m
//  MK61
//
//  Created by Andriy Gushuley on 12.08.12.
//
//

#import "MK61Logger.h"

@implementation MK61Logger

@synthesize label = _label;

- (void) logOperation: (id) operation {
    NSString* value = _label.text;
    if ( [value isEqualToString: @""] ) {
        value = [NSString stringWithFormat: @"%@", operation];
    } else {
        value = [[NSArray arrayWithObjects: value, @" ", operation, nil]
                    componentsJoinedByString: @""];
    }
    _label.text = value;
}

- (void) clear {
    _label.text = @"";
}

@end
