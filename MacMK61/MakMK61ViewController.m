//
//  MakMK61ViewController.m
//  MacMK61
//
//  Created by Andriy Gushuley on 05.09.12.
//  Copyright (c) 2012 Andriy Gushuley. All rights reserved.
//

#import "MakMK61ViewController.h"
#import "Mk61Brain.h"

@interface MakMK61ViewController()

@property BOOL userInMiddleOfNumberEntering;
@property IBOutlet NSTextField *display;
@property IBOutlet Mk61Brain *brain;
@property IBOutlet NSTextField *logger;

@end

@implementation MakMK61ViewController

@synthesize brain = _brain;
@synthesize display = _display;
@synthesize userInMiddleOfNumberEntering = _userInMiddleOfNumberEntering;

- (id)init
{
    self.userInMiddleOfNumberEntering = NO;
    return self;
}

- (IBAction) digitPressed: (NSButton*) sender {
    NSString *digit = sender.title;
    NSString *curValue = self.display.stringValue;
    if (!self.userInMiddleOfNumberEntering && ![digit isEqualToString:@"."]) {
        // replace for number if
        self.display.stringValue = digit;
        self.userInMiddleOfNumberEntering = YES;
        return;
    } else if ([digit isEqualToString:@"0"] && [curValue isEqualToString:@"0"]) {
        // Skip zero adding if string is exactly zero
        return;
    } else if ([digit isEqualToString:@"."]) {
        // Skip dot adding if dot is already found in number number found
        NSRange dotPosition = [curValue rangeOfString:@"."];
        if (dotPosition.location != NSNotFound) {
            return;
        }
    }
    self.userInMiddleOfNumberEntering = YES;
    self.display.stringValue = [curValue stringByAppendingString:digit];
}

- (IBAction) enterPressed: (NSButton*) sender {
    [self.brain pushValue: [self.display.stringValue doubleValue]];
    self.userInMiddleOfNumberEntering = NO;
}

- (IBAction) operationPressed: (NSButton*) sender {
    if (self.userInMiddleOfNumberEntering) {
        [self enterPressed: sender];
    }
    double result = [self.brain performOperation: sender.title];
    self.display.stringValue = [NSString stringWithFormat:@"%g", result];
}

- (IBAction) clearPressed: (NSButton*) sender {
    self.display.stringValue = @"0";
    if ( !_userInMiddleOfNumberEntering ) {
        [_brain clearCurrent];
    }
    self.userInMiddleOfNumberEntering = NO;
}

- (IBAction) fullClearPressed: (NSButton*) sender {
    [self clearPressed: sender];
    [self.brain clear];
}

- (void) viewDidUnload {
    [self setDisplay: nil];
    [self setBrain: nil];
}

- (void) logChanged: (NSString*) log;
{
    if ( !log ) {
        log = @"";
    }
    _logger.stringValue = log;
}

@end
