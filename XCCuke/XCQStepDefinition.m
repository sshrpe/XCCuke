//
//  XCQStepTestCase.m
//  XCCuke
//
//  Created by Stuart Sharpe on 02/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import "XCQStepDefinition.h"

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

@end
