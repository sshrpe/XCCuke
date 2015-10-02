//
//  GRTest.h
//  GherkinRunner
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

@import XCTest;
#import "XCQScenarioTestSuiteDelegate.h"

@class XCQScenario;

@interface XCQScenarioTestSuite : XCTestSuite

+ (instancetype)testSuiteWithScenario:(XCQScenario *)scenario
                           background:(XCQScenario *)background;

@property (strong) id<XCQScenarioTestSuiteDelegate> delegate;

@end

