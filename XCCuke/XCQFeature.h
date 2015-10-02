//
//  GRFeature.h
//  GherkinRunner
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCQScenario;

@interface XCQFeature : NSObject

- (instancetype)initWithTitle:(NSString *)title fileName:(NSString *)fileName;

@property (readonly, copy) NSString *fileName;

@property (readonly, copy) NSString *title;

@property (strong) XCQScenario *background;

@property (readonly) NSArray *scenarios;

- (void)addScenario:(XCQScenario *)scenario;

@end
