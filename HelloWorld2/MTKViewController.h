//
//  MTKViewController.h
//  HelloWorld2
//
//  Created by ios4341 on 22/03/14.
//  Copyright (c) 2014 ios4341. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTKViewController : UIViewController

- (IBAction)onOkClicked:(id)sender;
- (IBAction)onEqualClicked:(id)sender;
- (IBAction)onSlideMoved:(id)sender;
- (IBAction)onStepClicked:(id)sender;

@property (weak) IBOutlet UITextField * textField;
@property (weak) IBOutlet UILabel * textView;

@property (weak) IBOutlet UITextField * num1TextField;
@property (weak) IBOutlet UITextField * num2TextField;
@property (weak) IBOutlet UITextField * resultTextField;

@property (weak) IBOutlet UISlider * slider1;
@property (weak) IBOutlet UISlider * slider2;

@property (weak) IBOutlet UITextField * tabuadaTextField;

@end
