//
//  ButtonTap.m
//  XCCukeSampleApp
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <XCCuke/XCCuke.h>

@interface ButtonTap : XCQStepDefinition

@end

@implementation ButtonTap

- (void)ITapOnThe_Button:(NSString *)text {
    [[[XCUIApplication alloc] init].buttons[text] tap];
}

- (void)TheOutputLabelSays:(NSString *)text
{
    XCUIElement *element = [[[[XCUIApplication alloc] init] staticTexts] element];
    NSString *labelTitle = [element label];
    
    XCTAssertEqualObjects(text, labelTitle);
}


- (void)ITapOnTheHelloButton {
    // Replace this with your test code
    [[[XCUIApplication alloc] init].buttons[@"Hello"] tap];
}

- (void)ITapOnTheGoodbyeButton {
    // Replace this with your test code
    [self ITapOnThe_Button:@"Goodbye"];
}

- (void)ITapOnTheToodleooButton {
    // Replace this with your test code
    [self ITapOnThe_Button:@"Toodleoo"];
}


- (void)TheOutputLabelSaysHelloWorld {
    [self TheOutputLabelSays:@"Hello World"];
}

- (void)TheOutputLabelSaysGoodbyeCruelWorld {
    // Replace this with your test code
    [self TheOutputLabelSays:@"Goodbye Cruel World!"];
}


- (void)TheOutputLabelSaysTtfn {
    // Replace this with your test code
    [self TheOutputLabelSays:@"TTFN"];
}


@end
