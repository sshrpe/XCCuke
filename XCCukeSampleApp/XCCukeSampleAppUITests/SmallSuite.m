//
//  SmallSuite.m
//  XCCukeSampleApp
//
//  Created by Stuart Sharpe on 02/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import <XCCuke/XCCuke.h>
#import "LaunchAppObserver.h"

@interface SmallSuite : XCQTestSuite

@end

@implementation SmallSuite

XCQ_FEATURE_FILE_DIRECTORY(@"Features");

+ (NSArray *)featureFiles
{
    return @[[[NSBundle bundleForClass:[self class]] pathForResource:@"ButtonTap" ofType:@"feature"]];
}

+ (id<XCQScenarioTestSuiteObserver>)testObserver
{
    return [[LaunchAppObserver alloc] init];
}

@end
