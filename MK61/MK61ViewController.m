//
//  MK61ViewController.m
//  MK61
//
//  Created by Andriy Gushuley on 05.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MK61ViewController.h"
#import "Mk61Brain.h"

@interface MK61ViewController()

@property (nonatomic) BOOL userInMiddleOfNumberEntering;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (strong, nonatomic) IBOutlet Mk61Brain *brain;

@end

@implementation MK61ViewController

@synthesize brain = _brain;
@synthesize display = _display;
@synthesize userInMiddleOfNumberEntering = _userInMiddleOfNumberEntering;

- (id)init
{
    self.userInMiddleOfNumberEntering = NO; 
    return self;
}

- (IBAction)digitPressed:(UIButton*) sender {
    NSString *digit = sender.currentTitle;
    if (!self.userInMiddleOfNumberEntering && ![digit isEqualToString:@"."]) {
        // replace for number if 
        self.display.text = digit;
        self.userInMiddleOfNumberEntering = YES;
        return;
    } else if ([digit isEqualToString:@"0"] && [self.display.text isEqualToString:@"0"]) {
        // Skip zero adding if string is exactly zero
        return;  
    } else if ([digit isEqualToString:@"."]) {
        // Skip dot adding if dot is already found in number number found
        NSRange dotPosition = [self.display.text rangeOfString:@"."];
        if (dotPosition.location != NSNotFound) {
            return;
        }
    } 
    self.userInMiddleOfNumberEntering = YES;
    self.display.text = [self.display.text stringByAppendingString:digit];
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userInMiddleOfNumberEntering = NO;
}

- (IBAction)operationPressed:(UIButton*) sender {
    if (self.userInMiddleOfNumberEntering) {
        [self enterPressed];
    }
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];  
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.userInMiddleOfNumberEntering = NO;
}

- (IBAction)fullClearPressed {
    [self clearPressed];
    [self.brain clear];
}

- (void)viewDidUnload {
    [self setDisplay:nil];
    [self setBrain:nil];
    [super viewDidUnload];
}

@end
