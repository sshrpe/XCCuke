//
//  XCTestCase+XCQStepTestCase.m
//  XCCuke
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCTestCase+XCQStepTestCase.h"
#import "XCQStep.h"
#import "XCQStepDefinitionNotFoundCase.h"
#import <objc/runtime.h>

@implementation XCTestCase (XCQStepTestCase)

+ (XCTest *)testCaseWithStep:(XCQStep *)step;
{
    Class testClass = [self testClassForSelector:step.selector];
    if (testClass) {
        return [testClass testCaseWithSelector:step.selector];
    }
    return [[XCQStepDefinitionNotFoundCase alloc] initWithStep:step];
}

+ (Class)testClassForSelector:(SEL)selector
{
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++)
    {
        Class superClass = classes[i];
        do
        {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != [XCTestCase class]);
        
        if (superClass == nil)
        {
            continue;
        }
        
        [result addObject:classes[i]];
    }
    free(classes);
    
    for (Class subclass in result) {
        if ([subclass instancesRespondToSelector:selector]) {
            return subclass;
        }
    }
    return nil;
}


@end
