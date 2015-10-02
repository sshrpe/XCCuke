//
//  XCQScenarioTestSuiteDelegate.h
//  XCCuke
//
//  Created by Stuart Sharpe on 15/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

@import XCTest;

@class XCQScenario;

@protocol XCQScenarioTestSuiteDelegate <NSObject>

- (void) testSuite:(XCTestSuite *)suite willBeginTestingScenario:(XCQScenario *)scenario;

- (void) testSuite:(XCTestSuite *)suite didFinishTestingScenario:(XCQScenario *)scenario;

@end
