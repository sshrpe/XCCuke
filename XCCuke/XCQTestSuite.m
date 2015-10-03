//
//  XCQTestSuite.m
//  XCCuke
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQTestSuite.h"
#import "XCTestSuite+XCQFeatureTestSuite.h"

@implementation XCQTestSuite

+ (XCTestSuite *)defaultTestSuite
{
    NSArray *filePaths = [self featureFiles];
    if (!filePaths) {
        return nil;
    }
    return [XCTestSuite testSuiteWithFeaturesAtPaths:filePaths
                                               title:[self title]
                                           directory:[self featureFileDirectory]
                                            observer:[self testObserver]];
}

+ (NSArray *)featureFiles;
{
    return nil;
}

+ (NSString *)title;
{
    return NSStringFromClass(self);
}

+ (NSString *)featureFileDirectory
{
    return nil;
}

+ (id<XCQScenarioTestSuiteObserver>)testObserver
{
    return nil;
}

@end
