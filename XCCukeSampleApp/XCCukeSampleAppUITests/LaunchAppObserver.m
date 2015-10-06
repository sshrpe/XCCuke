//
//  LaunchAppObserver.m
//  XCCukeSampleApp
//
//  Created by Stuart Sharpe on 03/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import "LaunchAppObserver.h"

@implementation LaunchAppObserver

- (void)testSuite:(XCQScenarioTestSuite *)suite willBeginTestingScenario:(XCQScenario *)scenario
{
    NSLog(@"Pre-scenario callback: %@", scenario);
}

- (void)testSuite:(XCQScenarioTestSuite *)suite didFinishTestingScenario:(XCQScenario *)scenario
{
    NSLog(@"Post-scenario callback: %@", scenario);
    sleep(1);
}

- (void) testSuite:(XCQScenarioTestSuite *)suite uiTestingServerBeganForScenario:(XCQScenario *)scenario;
{
    NSLog(@"Launching Application");
    [[[XCUIApplication alloc] init] launch];

}

@end
