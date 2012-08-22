//
//  MK61StackItem.h
//  MK61
//
//  Created by Andriy Gushuley on 20.08.12.
//
//

#import <Foundation/Foundation.h>


@interface MK61StackItem : NSObject
- (id) initValue: (double) value
         visible: (id) value;

- (id) initUnaryOperation: (NSString*) operation
                    value: (double) value
                  operand: (id) operand;

- (id) initBinaryOperation: (NSString*) operation
                     value: (double) value
                    lvalue: (id) lvalue
                    rvalue: (id) rvalue;

- (id) initFunction: (NSString*) function
              value: (double) value
            operand: (id) operand;

+ (MK61StackItem*) createValue: (double) value
                       visible: (id) value;

+ (MK61StackItem*) createUnaryOperation:(NSString*) operation
                                  value: (double) value
                                operand: (id) operand;

+ (MK61StackItem*) createBinaryOperation: (NSString*) operation
                                   value: (double) value
                                  lvalue: (id) lvalue
                                  rvalue: (id) rvalue;

+ (MK61StackItem*) createFunction: (NSString*) operation
                            value: (double) value
                          operand: (id) operand;

@property (readonly) double value;

@end
