//
//  XCQScenario.h
//  XCCuke
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCQStep;

@interface XCQScenario : NSObject

- (void)addStep:(XCQStep *)step;

@property (copy) NSString *title;

@property (strong) NSArray *steps;

@end
