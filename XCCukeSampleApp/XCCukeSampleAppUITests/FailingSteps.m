//
//  FailingSteps.m
//  XCCukeSampleApp
//
//  Created by Stuart Sharpe on 01/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XCCuke/XCCuke.h>

@interface FailingSteps : XCQStepDefinition

@end

@implementation FailingSteps

- (void)AStepHasAFailure
{
    XCTFail(@"You must fail to succeed");
}

- (void)TheScenarioShouldFail
{
    XCTFail(@"Test should not continue after failing");
}

@end
