//
//  XCTestSuite+GRFeatureTestSuite.m
//  XCCuke
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCTestSuite+XCQFeatureTestSuite.h"
#import "XCQFeature.h"
#import "XCQScenarioTestSuite.h"
#import "XCQFeatureParser.h"
#import "XCQStepDefinitionNotFoundCase.h"

@implementation XCTestSuite (XCQFeatureTestSuite)

+ (instancetype)testSuiteWithFeaturesAtPaths:(NSArray *)filePaths
                                       title:(NSString *)title
                                   directory:(NSString *)directory
                                    observer:(id<XCQScenarioTestSuiteObserver>)observer
{
    XCTestSuite *suite = [XCTestSuite testSuiteWithName:title];

    for (NSString *path in filePaths) {
        XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:path directory:directory];
        [suite addTest:[XCTestSuite testSuiteWithFeature:feature
                                             observer:observer]];
    }
    return suite;
}

+ (instancetype)testSuiteWithFeature:(XCQFeature *)feature observer:(id<XCQScenarioTestSuiteObserver>)observer

{
    XCTestSuite *featureSuite = [XCTestSuite testSuiteWithName:[NSString stringWithFormat:@"Feature: %@", feature.title]];
    
    XCQScenario *background = feature.background;
    for (XCQScenario *scenario in feature.scenarios) {
        XCQScenarioTestSuite *scenarioSuite = [XCQScenarioTestSuite testSuiteWithScenario:scenario
                                                                               background:background
                                                                                 observer:observer];
        [featureSuite addTest:scenarioSuite];
    }
    return featureSuite;
}

@end
