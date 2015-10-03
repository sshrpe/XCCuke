//
//  ExampleSuite.m
//  XCCuke
//
//  Created by Stuart Sharpe on 15/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQTestSuite.h"

@interface ExampleObserver : NSObject <XCQScenarioTestSuiteObserver>

@end

@implementation ExampleObserver

- (void)testSuite:(XCQScenarioTestSuite *)suite willBeginTestingScenario:(XCQScenario *)scenario
{
    NSLog(@"PRE-SCENARIO HOOK: %@", scenario);
}

- (void)testSuite:(XCQScenarioTestSuite *)suite didFinishTestingScenario:(XCQScenario *)scenario
{
    NSLog(@"POST-SCENARIO HOOK: %@", scenario);
}

@end

@interface ExampleSuite : XCQTestSuite

@end

@implementation ExampleSuite

XCQ_FEATURE_FILE_DIRECTORY(@"");

+ (NSArray *)featureFiles {
    return @[[[NSBundle bundleForClass:self] pathForResource:@"Feature" ofType:@"feature"]];
}

+ (id<XCQScenarioTestSuiteObserver>)testObserver
{
    return [[ExampleObserver alloc] init];
}

@end
