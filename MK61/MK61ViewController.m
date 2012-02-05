//
//  MK61ViewController.m
//  MK61
//
//  Created by Andriy Gushuley on 05.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MK61ViewController.h"

@interface MK61ViewController()

@property (nonatomic) BOOL userInMiddleOfNumberEntering;
@property (weak, nonatomic) IBOutlet UILabel *display;

@end

@implementation MK61ViewController

@synthesize display = _display, userInMiddleOfNumberEntering = _userInMiddleOfNumberEntering;

- (IBAction)digitPressed:(UIButton*) sender {
    if (self.userInMiddleOfNumberEntering) {
        self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
    } else {
        self.display.text = sender.currentTitle;
        self.userInMiddleOfNumberEntering = YES;
    }
}

- (IBAction)enterPressed {
    self.userInMiddleOfNumberEntering = NO;
}

- (IBAction)operationPressed:(UIButton*) sender {
    NSLog(@"Operattion pressed: %@", sender.currentTitle);
}

- (void)viewDidUnload {
    [self setDisplay:nil];
    [super viewDidUnload];
}
@end
