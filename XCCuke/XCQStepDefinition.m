//
//  XCQStepTestCase.m
//  XCCuke
//
//  Created by Stuart Sharpe on 02/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import "XCQStepDefinition.h"
#import "XCQStepDefinitionNotFoundCase.h"
#import "XCQDefaultSelectorBuilder.h"
#import "XCQStepDefinitionFinder.h"

@interface XCTestCase ()

- (void)startActivityWithTitle:(NSString *)title block:(void(^)(void))block;

@end

@implementation XCQStepDefinition

- (void)startActivityWithTitle:(NSString *)title block:(void(^)(void))block {
    [super startActivityWithTitle:title block:block];
    if ([title isEqualToString:@"Start Test"]) {
        [self.delegate uiTestingServerActive];
    }
}

+ (XCTest *)testCaseWithStep:(XCQStep *)step;
{
    XCQDefaultSelectorBuilder *selectorBuilder = [[XCQDefaultSelectorBuilder alloc] init];
    SEL selector = [selectorBuilder selectorForStep:step];
    Class testClass = [XCQStepDefinitionFinder testClassForSelector:selector];
    if (testClass) {
        return [testClass testCaseWithSelector:selector];
    }
    return [[XCQStepDefinitionNotFoundCase alloc] initWithStep:step selectorBuilder:selectorBuilder];
}


@end
