//
//  XCQFeatureParser.m
//  XCCuke
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQFeatureParser.h"
#import "XCQFeature.h"
#import "XCQScenario.h"
#import "XCQStep.h"

static NSString *const kFeaturePrefix = @"Feature: ";
static NSString *const kBackgroundPrefix = @"Background:";
static NSString *const kScenarioPrefix = @"Scenario: ";
static NSString *const kScenarioOutlinePrefix = @"Scenario Outline: ";

@interface XCQFeatureParser ()

@property (copy) NSString *filePath;
@property (copy) NSString *directory;
@property (strong) XCQFeature *currentFeature;
@property (strong) XCQScenario *currentScenario;

@property (strong) NSString *currentOutlineTitle;
@property (strong) NSMutableArray *currentOutlineSteps;
@property (strong) NSArray *currentParameterTitles;

@property (strong) NSSet<NSString *> *featureTags;
@property (strong) NSSet<NSString *> *scenarioTags;

@end

@implementation XCQFeatureParser {
    BOOL _outline;
    NSUInteger _lineNumber;
}

+ (XCQFeature *)featureWithFeatureFilePath:(NSString *)featureFilePath;
{
    return [self featureWithFeatureFilePath:featureFilePath directory:nil];
}

+ (XCQFeature *)featureWithFeatureFilePath:(NSString *)featureFilePath directory:(NSString *)directory;
{
    XCQFeatureParser *parser = [[XCQFeatureParser alloc] initWithFilePath:featureFilePath directory:directory];
    
    XCQFeature *feature = [parser parse];
    return feature;
}


- (instancetype)initWithFilePath:(NSString *)filePath directory:(NSString *)directory;
{
    self = [super init];
    if (self) {
        self.filePath = filePath;
        self.directory = directory;
        _lineNumber = 0;
    }
    return self;
}

- (XCQFeature *)parse
{
    NSString *fileString = [NSString stringWithContentsOfFile:self.filePath
                                                     encoding:NSUTF8StringEncoding error:nil];
    

    NSScanner *scanner = [[NSScanner alloc] initWithString:fileString];
    while (![scanner isAtEnd]) {
        _lineNumber++;
        // Scan a single line of the feature file
        NSString *line = nil;
        [scanner setCharactersToBeSkipped:nil];
        if ([scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&line]) {
            line = [self sanitisedLineFromLine:line];
            if (line) {
                [self parseLine:line];
            }
        }
        if (![scanner isAtEnd]) {
            scanner.scanLocation = scanner.scanLocation+1;
        }
    }
    return self.currentFeature;
}

- (NSString *)sanitisedLineFromLine:(NSString *)line
{
    // Strip whitespace
    line = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // Empty lines mean scenarios are finished
    if ([line length]) {
        // Strip comments
        NSArray *comps = [line componentsSeparatedByString:@"#"];
        line = [comps firstObject];
        
        // Strip whitespace again!
        line = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([line length]) {
            return line;
        }
    }
    return nil;
}


- (void)parseLine:(NSString *)line
{    
    // Feature titles
    if ([line hasPrefix:kFeaturePrefix]) {
        [self beginFeatureWithTitle:[line stringByReplacingOccurrencesOfString:kFeaturePrefix withString:@""]];
    }
    // Background
    else if ([line hasPrefix:kBackgroundPrefix]) {
        [self addBackgroundScenario];
    }
    // Scenario titles
    else if ([line hasPrefix:kScenarioPrefix]) {
        [self beginScenarioWithTitle:[line stringByReplacingOccurrencesOfString:kScenarioPrefix withString:@""]];
    }
    // Scenario outlines
    else if ([line hasPrefix:kScenarioOutlinePrefix]) {
        [self beginScenarioOutlineWithTitle:[line stringByReplacingOccurrencesOfString:kScenarioOutlinePrefix withString:@""]];
    }
    else if ([line hasPrefix:@"|"]) {
        [self addParameters:[line componentsSeparatedByString:@"|"]];
    }
    // Steps
    else if ([line hasPrefix:@"Given "] || [line hasPrefix:@"When "] || [line hasPrefix:@"Then "] || [line hasPrefix:@"And "]) {
        NSRegularExpression *scenarioExpression = [[NSRegularExpression alloc] initWithPattern:@"^(Given |When |Then |And )"
                                                                                       options:0
                                                                                         error:nil];
        NSArray *matches = [scenarioExpression matchesInString:line options:0 range:NSMakeRange(0, [line length])];
        NSTextCheckingResult *match = [matches firstObject];
        [self addStep:[line substringFromIndex:match.range.location+match.range.length]];
    } else {
        // Scan for tags
        NSRegularExpression *tagExpression = [[NSRegularExpression alloc] initWithPattern:@"@([a-zA-Z0-9]+)"
                                                                                options:0
                                                                                  error:nil];
        NSArray *matches = [tagExpression matchesInString:line options:0 range:NSMakeRange(0, [line length])];
        if ([matches count]) {
            NSMutableSet<NSString *> *tags = [NSMutableSet set];
            for (NSTextCheckingResult *result in matches) {
                NSString *tag = [line substringWithRange:[result rangeAtIndex:1]];
                [tags addObject:tag];
            }
            
            if (!self.currentFeature) {
                self.featureTags = [NSSet setWithSet:tags];
            } else {
                self.scenarioTags = [NSSet setWithSet:tags];
            }
        } else {
            // Unknown line
            NSLog(@"Ignoring Line in Feature File: %@", line);
        }

    }
}

- (void)beginFeatureWithTitle:(NSString *)title;
{
    [self endOutline];

    self.currentFeature = [[XCQFeature alloc] initWithTitle:title fileName:[self.filePath lastPathComponent]];
}

- (void)addBackgroundScenario
{
    self.currentScenario = [[XCQScenario alloc] init];
    self.currentScenario.title = @"Background";
    self.currentFeature.background = self.currentScenario;
}

- (void)beginScenarioWithTitle:(NSString *)title;
{
    [self endOutline];
    self.currentScenario = [[XCQScenario alloc] init];
    self.currentScenario.title = title;
    [self.currentFeature addScenario:self.currentScenario];
    self.currentScenario.tags = [self.featureTags setByAddingObjectsFromSet:self.scenarioTags];
}

- (void)beginScenarioOutlineWithTitle:(NSString *)title
{
    _outline = YES;
    self.currentOutlineTitle = title;
    self.currentOutlineSteps = [NSMutableArray array];
}

- (void)endOutline
{
    _outline = NO;
    self.currentOutlineTitle = nil;
    self.currentOutlineSteps = nil;
}

- (void)addParameters:(NSArray *)parameters
{
    parameters = [self sanitiseParameters:parameters];
    if (!self.currentParameterTitles) {
        self.currentParameterTitles = parameters;
    } else {
        XCQScenario *scenario = [[XCQScenario alloc] init];
        scenario.title = self.currentOutlineTitle;
        for (XCQStep *step in self.currentOutlineSteps) {
            [scenario addStep:[self applyParameters:parameters toStep:step]];
        }
        [self.currentFeature addScenario:scenario];
    }
}

- (NSArray *)sanitiseParameters:(NSArray *)parameters {
    NSArray *titles = [parameters filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.length > 0"]];
    NSMutableArray *strippedTitles = [NSMutableArray array];
    for (NSString *title in titles) {
        [strippedTitles addObject:[title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    return [NSArray arrayWithArray:strippedTitles];
}

- (XCQStep *)applyParameters:(NSArray *)parameters toStep:(XCQStep *)step
{
    NSString *output = [step text];
    for (NSInteger i=0; i < self.currentParameterTitles.count; i++) {
        NSString *key = [NSString stringWithFormat:@"<%@>", self.currentParameterTitles[i]];
        output = [output stringByReplacingOccurrencesOfString:key withString:parameters[i]
                                                      options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch
                                                        range:NSMakeRange(0, output.length)];
    }
    return [XCQStep stepWithText:output
                        filePath:[self.directory stringByAppendingPathComponent:[self.currentFeature fileName]]
                      lineNumber:step.lineNumber];
}

- (void)addStep:(NSString *)text
{
    XCQStep *step = [XCQStep stepWithText:text filePath:[self.directory stringByAppendingPathComponent:[self.currentFeature fileName]] lineNumber:_lineNumber];
    
    if (_outline) {
        [self.currentOutlineSteps addObject:step];
    } else {
        [self.currentScenario addStep:step];
    }
}


@end
