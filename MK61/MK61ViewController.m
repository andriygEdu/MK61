//
//  MK61ViewController.m
//  MK61
//
//  Created by Andriy Gushuley on 05.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MK61ViewController.h"

@implementation MK61ViewController

@synthesize display = _display;

- (IBAction)digitPressed:(UIButton*) sender {
    NSString *digit = sender.currentTitle;
    NSLog(@"Button pressed: %@", digit);
}

@end
