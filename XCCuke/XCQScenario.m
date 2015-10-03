//
//  XCQScenario.m
//  XCCuke
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQScenario.h"
#import "XCQStep.h"

@implementation XCQScenario

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.steps = [NSArray array];
    }
    return self;
}

- (void)addStep:(XCQStep *)step;
{
    self.steps = [self.steps arrayByAddingObject:step];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Scenario: %@", _title];
}

@end
