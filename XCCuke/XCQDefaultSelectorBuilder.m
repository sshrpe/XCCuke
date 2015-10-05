//
//  XCQSelectorBuilder.m
//  XCCuke
//
//  Created by Stuart Sharpe on 05/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import "XCQDefaultSelectorBuilder.h"

@implementation XCQDefaultSelectorBuilder

- (SEL)selectorForStep:(XCQStep *)step
{
    NSArray *components = [[[step text] capitalizedString] componentsSeparatedByCharactersInSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]];
    NSString *selectorString = [components componentsJoinedByString:@" "];
    selectorString = [selectorString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return NSSelectorFromString(selectorString);
}

@end
