//
//  XCQStepDefinitionNotFoundCase.m
//  XCCuke
//
//  Created by Stuart Sharpe on 14/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQStepDefinitionNotFoundCase.h"
#import "XCQStep.h"
#import "XCQFeature.h"

@interface XCQStepDefinitionNotFoundCase ()

@property (strong) XCQStep *step;
@property (strong) id<XCQSelectorBuilder> selectorBuilder;

@end

@implementation XCQStepDefinitionNotFoundCase

- (instancetype)initWithStep:(XCQStep *)step selectorBuilder:(id<XCQSelectorBuilder>)builder;
{
    self = [super initWithSelector:@selector(stepNotFound)];
    if (self) {
        self.step = step;
        self.selectorBuilder = builder;
    }
    return self;
}


/*!
 * @property name
 * Test's name. Must be overridden by subclasses.
 */
- (NSString *)name;
{
    return self.step.text;
}

/*!
 * @method -performTest:
 * The method through which tests are executed. Must be overridden by subclasses.
 */
- (void)performTest:(XCTestRun *)run;
{
    [run start];
    NSString *errorDescription = [NSString stringWithFormat:@"Cannot find step definition for '%@'", [self.step text]];
    NSString *selector = NSStringFromSelector([self.selectorBuilder selectorForStep:self.step]);
    NSLog(@"WARNING: %@ Step definition not found. \n\nTo fix this error, add the following step definition:\n\n\
// Objective-C:\n- (void)%@ {\n\t// Replace this with your test code\n\tNSLog(@\"Step Definition Pending\");\n}\n\n\
// Swift:\nfunc %@() {\n\t// Replace this with your test code.\n\tprint(\"Step Definition Pending\")\n}\n\n", errorDescription, selector, selector);
    

    NSString *filePath = [self.step filePath];
    [run recordFailureWithDescription:errorDescription
                               inFile:filePath
                               atLine:self.step.lineNumber
                             expected:NO];
    [run stop];
}

- (void)stepNotFound
{
    
}

/*!
 * @method -setUp
 * Setup method called before the invocation of each test method in the class.
 */
- (void)setUp;
{
    
}

/*!
 * @method -tearDown
 * Teardown method called after the invocation of each test method in the class.
 */
- (void)tearDown;
{
    
}

@end
