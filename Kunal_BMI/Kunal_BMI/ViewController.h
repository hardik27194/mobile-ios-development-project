//
//  ViewController.h
//  Kunal_BMI
//
//  Created by kunal sontakke on 9/19/15.
//  Copyright (c) 2015 kunal sontakke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *heightText;


@property (weak, nonatomic) IBOutlet UITextField *weightText;


@property (weak, nonatomic) IBOutlet UILabel *heightDim;

@property (weak, nonatomic) IBOutlet UILabel *weightDim;

- (IBAction)unitSwitch:(id)sender;


- (IBAction)calculate:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *bmi;

@property (weak, nonatomic) IBOutlet UILabel *bmiDesc;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

