//
//  XCTestSuite+GRFeatureTestSuite.h
//  XCCuke
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import <XCTest/XCTest.h>

@class XCQFeature;
@protocol XCQScenarioTestSuiteObserver;

@interface XCTestSuite (XCQFeatureTestSuite)

+ (instancetype)testSuiteWithFeaturesAtPaths:(NSArray *)filePaths
                                       title:(NSString *)title
                                   directory:(NSString *)directory
                                    observer:(id<XCQScenarioTestSuiteObserver>)observer;

+ (instancetype)testSuiteWithFeature:(XCQFeature *)feature observer:(id<XCQScenarioTestSuiteObserver>)observer;

@end
