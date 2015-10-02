//
//  GRStep.h
//  GherkinRunner
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCQFeature;

@interface XCQStep : NSObject

+ (instancetype)stepWithText:(NSString *)text filePath:(NSString *)filePath lineNumber:(NSUInteger)lineNumber;

@property (readonly, copy) NSString *filePath;
@property (readonly, copy) NSString *text;
@property (readonly, assign) NSUInteger lineNumber;

- (SEL)selector;

@end
