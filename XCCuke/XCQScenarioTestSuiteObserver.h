//
//  XCQScenarioTestSuiteObserver.h
//  XCCuke
//
//  Created by Stuart Sharpe on 15/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

@import XCTest;

@class XCQScenarioTestSuite;
@class XCQScenario;

@protocol XCQScenarioTestSuiteObserver <NSObject>


/**
 @method testSuite:willBeginTestingScenario:
 Called before each scenario in the suite is started. This method should be used when running Unit 
 Test suites, or for any pre-scenario environment setup required outside of Xcode UI Tests.
 
 @warning Because the method is called before the test begins, -[XCUIApplication launch] cannot be 
 used within this method.
 */
- (void) testSuite:(XCQScenarioTestSuite *)suite willBeginTestingScenario:(XCQScenario *)scenario;

/**
 @method testSuite:didFinishTestingScenario:
 Called after the scenario test has been completed. Use this method to teardown any environment
 changes required for an entire scenario.
 */
- (void) testSuite:(XCQScenarioTestSuite *)suite didFinishTestingScenario:(XCQScenario *)scenario;

@optional

/**
 @method testSuite:uiTestingServerBeganForScenario:
 Called during UI Test runs when the XCUIApplication becomes connected to the simulator. If you wish
 to relaunch the XCUIApplication between scenarios (without requiring a relaunch step in your 
 feature's background), implement this method and call [[[XCUIApplication alloc] init] launch].
 */
- (void) testSuite:(XCQScenarioTestSuite *)suite uiTestingServerBeganForScenario:(XCQScenario *)scenario;

@end
