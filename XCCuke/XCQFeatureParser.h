//
//  XCQFeatureParser.h
//  XCCuke
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCQFeature;

@interface XCQFeatureParser : NSObject

+ (XCQFeature *)featureWithFeatureFilePath:(NSString *)featureFilePath;

+ (XCQFeature *)featureWithFeatureFilePath:(NSString *)featureFilePath directory:(NSString *)directory;

@end
