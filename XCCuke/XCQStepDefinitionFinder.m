//
//  XCQStepDefinitionFinder.m
//  XCCuke
//
//  Created by Stuart Sharpe on 05/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import "XCQStepDefinitionFinder.h"
#import <objc/runtime.h>
#import "XCQStepDefinition.h"

@implementation XCQStepDefinitionFinder

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
        } while(superClass && superClass != [XCQStepDefinition class]);
        
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
