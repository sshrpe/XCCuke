//
//  ViewController.m
//  XCCukeSampleApp
//
//  Created by Stuart Sharpe on 01/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sayHello:(id)sender {
    self.outputLabel.text = @"Hello World";
}

- (IBAction)sayGoodbye:(id)sender {
    self.outputLabel.text = @"Goodbye Cruel World!";
}

- (IBAction)sayToodleoo:(id)sender {
    self.outputLabel.text = @"TTFN";
}

@end
