//
//  MK61StackItem.h
//  MK61
//
//  Created by Andriy Gushuley on 20.08.12.
//
//

#import <Foundation/Foundation.h>

enum MK61StackItemOperationPriorities {
    MK61StackItemOperationNoPrioriyty = 0,
    MK61StackItemOperationPriorityAddition = 50,
    MK61StackItemOperationPriorityMultiplication = 100
};

@interface MK61StackItem : NSObject
- (id) initValue: (double) value
         visible: (id) value;

- (id) initUnaryOperation: (NSString*) operation
                    value: (double) value
                  operand: (MK61StackItem*) operand;

- (id) initBinaryOperation: (NSString*) operation
                     value: (double) value
                    lvalue: (MK61StackItem*) lvalue
                    rvalue: (MK61StackItem*) rvalue
                  priority: (int) priority;

- (id) initFunction: (NSString*) function
              value: (double) value
            operand: (MK61StackItem*) operand;

+ (MK61StackItem*) createValue: (double) value
                       visible: (id) value;

+ (MK61StackItem*) createUnaryOperation:(NSString*) operation
                                  value: (double) value
                                operand: (MK61StackItem*) operand;

+ (MK61StackItem*) createBinaryOperation: (NSString*) operation
                                   value: (double) value
                                  lvalue: (MK61StackItem*) lvalue
                                  rvalue: (MK61StackItem*) rvalue
                                priority: (int) priority;

+ (MK61StackItem*) createFunction: (NSString*) operation
                            value: (double) value
                          operand: (MK61StackItem*) operand;

@property (readonly) double value;

@end
