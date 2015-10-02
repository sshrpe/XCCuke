//
//  GRFeature.m
//  GherkinRunner
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQFeature.h"

@interface XCQFeature ()

@property (copy) NSString *title;
@property (copy) NSString *fileName;
@property (strong) NSArray *scenarios;

@end

@implementation XCQFeature

- (instancetype)initWithTitle:(NSString *)title fileName:(NSString *)fileName;
{
    self = [super init];
    if (self) {
        self.title = title;
        self.fileName = fileName;
        self.scenarios = [NSArray array];
    }
    return self;
}

- (void)addScenario:(XCQScenario *)scenario
{
    self.scenarios = [self.scenarios arrayByAddingObject:scenario];
}

@end
