//
//  XCTestCase+XCQStepTestCase.h
//  XCCuke
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import <XCTest/XCTest.h>

@class XCQStep;
@class XCQFeature;

@interface XCTestCase (XCQStepTestCase)

+ (XCTest *)testCaseWithStep:(XCQStep *)step;

@end
