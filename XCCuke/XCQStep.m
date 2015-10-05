//
//  XCQStep.m
//  XCCuke
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQStep.h"

@interface XCQStep ()

@property (copy) NSString *filePath;
@property (copy) NSString *text;
@property (assign) NSUInteger lineNumber;


@end

@implementation XCQStep

+ (instancetype)stepWithText:(NSString *)text filePath:(NSString *)filePath lineNumber:(NSUInteger)lineNumber {
    XCQStep *step = [[XCQStep alloc] init];
    step.text = text;
    step.filePath = filePath;
    step.lineNumber = lineNumber;
    return step;
}

@end
