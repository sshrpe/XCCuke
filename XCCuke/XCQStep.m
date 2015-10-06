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
    XCQStep *step = [[XCQStep alloc] initWithText:text filePath:filePath lineNumber:lineNumber];
    return step;
}

- (instancetype)initWithText:(NSString *)text filePath:(NSString *)filePath lineNumber:(NSUInteger)lineNumber
{
    self = [super init];
    if (self) {
        self.text = text;
        self.filePath = filePath;
        self.lineNumber = lineNumber;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"XCQStep: %@ (%@:%@)", self.text, self.filePath, @(self.lineNumber)];
}

@end
