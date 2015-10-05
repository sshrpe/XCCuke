//
//  XCQStepDefinitionNotFoundCase.h
//  XCCuke
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCQStepDefinition.h"
#import "XCQSelectorBuilder.h"

@class XCQStep;

@interface XCQStepDefinitionNotFoundCase : XCQStepDefinition

- (instancetype)initWithStep:(XCQStep *)step selectorBuilder:(id<XCQSelectorBuilder>)builder;

@property (readonly) XCQStep *step;

@end
