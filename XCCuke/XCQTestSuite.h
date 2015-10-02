//
//  XCQTestSuite.h
//  XCCuke
//
//  Created by Stuart Sharpe on 15/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

@import XCTest;
#import "XCQScenarioTestSuiteDelegate.h"
@class XCQScenario;

#define XCQ_FEATURE_FILE_DIRECTORY(dir) \
+ (NSString *)featureFileDirectory { \
return [[@__FILE__ stringByDeletingLastPathComponent] stringByAppendingPathComponent:dir]; \
}


#define XCQ_INCLUDE_ALL_FEATURES_IN_BUNDLE() \
+ (NSArray *)featureFiles { \
return [[NSBundle bundleForClass:self] pathsForResourcesOfType:@"feature" inDirectory:nil]; \
}


/**
 @class XCQTestSuite
 
 @abstract In order to run feature files, at least one subclass of XCQTestSuite *must* be present in the testing
 target. This subclass should either implment +featureFiles and return an array of file paths for
 the feature files which should be included in the test suite, or should call
 `XCQ_INCLUDE_ALL_FEATURES_IN_BUNDLE()` within the @implementation block to create a suite which
 will run all feature files in the bundle.
 */
@interface XCQTestSuite : XCTestCase <XCQScenarioTestSuiteDelegate>

/**
 Returns a list of file paths to the feature files which should be run in this test suite.
 You can override this method to create individual test suites which will run a subset of
 feature files, or else include XCQ_INCLUDE_ALL_FEATURES_IN_BUNDLE() in an XCQTestSuite subclass
 inside your unit test target to create a suite which includes all feature files in the bundle.
 
 @return An array of file paths for feature files.
 */
+ (NSArray *) featureFiles;

/**
 The title of the test suite. The title will appear in test output and in the Xcode
 interface.
 
 @return Default implementation returns the class name.

 */
+ (NSString *) title;

@end

