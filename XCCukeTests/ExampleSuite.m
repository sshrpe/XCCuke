//
//  ExampleSuite.m
//  XCCuke
//
//  Created by Stuart Sharpe on 15/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQTestSuite.h"

@interface ExampleSuite : XCQTestSuite

@end

@implementation ExampleSuite

XCQ_FEATURE_FILE_DIRECTORY(@"");

+ (NSArray *)featureFiles {
    return @[[[NSBundle bundleForClass:self] pathForResource:@"Feature" ofType:@"feature"]];
}

@end
