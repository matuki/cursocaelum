//
//  MTKViewController.m
//  HelloWorld2
//
//  Created by ios4341 on 22/03/14.
//  Copyright (c) 2014 ios4341. All rights reserved.
//

#import "MTKViewController.h"

@interface MTKViewController ()

@end

@implementation MTKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onOkClicked:(id)sender
{
    NSString *typedText = self.textField.text;
    self.textView.text = typedText;
    NSLog(@"Typed text %@", typedText);
}

- (IBAction)onSlideMoved:(UISlider *) slider
{
    float currentValue = [slider value];
    
    NSString* strCurrentValue = [NSString stringWithFormat:@"%.4f", currentValue];
    
    if (slider == self.slider1) {
        self.num1TextField.text = strCurrentValue;
    } else {
        self.num2TextField.text = strCurrentValue;
    }
    
    self.num1TextField.text = [NSString stringWithFormat:@"%f", currentValue];
}

- (IBAction)onEqualClicked:(id)sender
{
    float result =  [self.num1TextField.text floatValue] + [self.num2TextField.text floatValue];
    self.resultTextField.text = [NSString stringWithFormat:@"%f", result];
}

- (IBAction)onStepClicked:(UIStepper *)stepper
{
    self.tabuadaTextField.text = [NSString stringWithFormat:@"%f", stepper.value];
    
    for (int i = 1; i < 10; i++) {
        int result = i * stepper.value;
        NSLog(@"%d * % d = %d", i, (int) stepper.value, result);
    } 
}


@end
