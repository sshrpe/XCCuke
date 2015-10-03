//
//  XCQStepTestCase.h
//  XCCuke
//
//  Created by Stuart Sharpe on 02/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import <XCTest/XCTest.h>

@protocol XCQStepTestCaseDelegate <NSObject>

- (void)uiTestingServerActive;

@end

@interface XCQStepDefinition : XCTestCase

@property (weak) id<XCQStepTestCaseDelegate> delegate;

@end
