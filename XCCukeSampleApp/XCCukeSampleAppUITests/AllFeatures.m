
//  XCQTestController.m
//  XCCukeSampleApp
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

@import XCTest;
#import <XCCuke/XCCuke.h>
#import "LaunchAppObserver.h"

@interface AllFeatures : XCQTestSuite

@end

@implementation AllFeatures

XCQ_INCLUDE_ALL_FEATURES_IN_BUNDLE()

XCQ_FEATURE_FILE_DIRECTORY(@"Features");

+ (id<XCQScenarioTestSuiteObserver>)testObserver
{
    return [[LaunchAppObserver alloc] init];
}

@end

