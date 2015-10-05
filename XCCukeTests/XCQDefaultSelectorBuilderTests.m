//
//  XCQDefaultSelectorBuilderTests.m
//  XCCuke
//
//  Created by Stuart Sharpe on 05/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCQStep.h"
#import "XCQDefaultSelectorBuilder.h"

@interface XCQDefaultSelectorBuilderTests : XCTestCase

@end

@implementation XCQDefaultSelectorBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStepsWithSpecialCharactersAreGivenCorrectSelectors
{
    XCQStep *step = [XCQStep stepWithText:@"the action_type is menu-tap" filePath:nil lineNumber:0];
    XCQDefaultSelectorBuilder *builder = [[XCQDefaultSelectorBuilder alloc] init];
    
    SEL selector = [builder selectorForStep:step];
    XCTAssertEqualObjects(@"TheActionTypeIsMenuTap", NSStringFromSelector(selector));
}

- (void)testStepsWithSpecialCharactersAreGivenCorrectCapitalisation
{
    XCQStep *step = [XCQStep stepWithText:@"it isn't capitalised strangely" filePath:nil lineNumber:0];
    XCQDefaultSelectorBuilder *builder = [[XCQDefaultSelectorBuilder alloc] init];
    
    SEL selector = [builder selectorForStep:step];
    XCTAssertEqualObjects(@"ItIsntCapitalisedStrangely", NSStringFromSelector(selector));
}

- (void)testSpecialCharactersAreIgnored
{
    XCQStep *step = [XCQStep stepWithText:@"The special characters 😃🎉👿💩🍆★☆✩🍑😓🇨🇦 are ignored" filePath:nil lineNumber:0];
    XCQDefaultSelectorBuilder *builder = [[XCQDefaultSelectorBuilder alloc] init];

    SEL selector = [builder selectorForStep:step];
    XCTAssertEqualObjects(@"TheSpecialCharactersAreIgnored", NSStringFromSelector(selector));

}

@end
