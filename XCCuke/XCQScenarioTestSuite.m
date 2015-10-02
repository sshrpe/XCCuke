//
//  GRTest.m
//  GherkinRunner
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQScenarioTestSuite.h"
#import "XCQFeature.h"
#import "XCQScenario.h"
#import "XCQStep.h"
#import "XCTestCase+XCQStepTestCase.h"

@interface XCQScenarioTestSuite ()

@property (strong) XCQScenario *scenario;

@end

@implementation XCQScenarioTestSuite

+ (instancetype)testSuiteWithScenario:(XCQScenario *)scenario
                           background:(XCQScenario *)background;
{
    XCQScenarioTestSuite *scenarioSuite = [XCQScenarioTestSuite testSuiteWithName:[NSString stringWithFormat:@"Scenario: %@", scenario.title]];
    scenarioSuite.scenario = scenario;
    
    for (XCQStep *step in background.steps) {
        [scenarioSuite addTest:[XCTestCase testCaseWithStep:step]];
    }
    for (XCQStep *step in scenario.steps) {
        [scenarioSuite addTest:[XCTestCase testCaseWithStep:step]];
    }
    return scenarioSuite;
}

- (XCTestRun *)run
{
    XCTestSuiteRun *suiteRun = [[XCTestSuiteRun alloc] initWithTest:self];
    [suiteRun start];
    
    [self.delegate testSuite:self willBeginTestingScenario:self.scenario];
    for (XCTestCase *testCase in self.tests) {
        XCTestRun *testRun = [testCase run];
        [suiteRun addTestRun:testRun];
        if (![testRun hasSucceeded]) {
            break;
        }
    }
    [self.delegate testSuite:self didFinishTestingScenario:self.scenario];
    
    [suiteRun stop];
    return suiteRun;
}

@end

