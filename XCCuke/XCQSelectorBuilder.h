//
//  XCQSelectorBuilder.h
//  XCCuke
//
//  Created by Stuart Sharpe on 05/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCQStep.h"

@protocol XCQSelectorBuilder <NSObject>

- (SEL)selectorForStep:(XCQStep *)step;

@end
