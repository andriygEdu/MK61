//
//  MK61Logger.h
//  MK61
//
//  Created by Andriy Gushuley on 12.08.12.
//
//

#import <Foundation/Foundation.h>

@interface MK61Logger : NSObject

// Add operation for logging
- (void) logOperation: (id) operation;
// Clear logger strip
- (void) clear;

// Link for connection UILabel to logger
@property IBOutlet UILabel* label;

@end
