//
//  XCQScenarioTestSuite.h
//  XCCuke
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

@import XCTest;
#import "XCQScenarioTestSuiteObserver.h"

@class XCQScenario;

@interface XCQScenarioTestSuite : XCTestSuite

+ (instancetype)testSuiteWithScenario:(XCQScenario *)scenario
                           background:(XCQScenario *)background
                             observer:(id<XCQScenarioTestSuiteObserver>)observer;

@property (readonly) XCQScenario *scenario;

@end

