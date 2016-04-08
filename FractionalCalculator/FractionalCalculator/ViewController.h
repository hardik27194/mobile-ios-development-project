//
//  ViewController.h
//  FractionalCalculator
//
//  Created by kunal sontakke on 10/18/15.
//  Copyright (c) 2015 kunal sontakke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Display.h"
#import "FractionHandler.h"
#import "Calculate.h"
@interface ViewController : UIViewController

- (IBAction)label1:(id)sender;
- (IBAction)label2:(id)sender;
- (IBAction)label3:(id)sender;
- (IBAction)label4:(id)sender;
- (IBAction)label5:(id)sender;
- (IBAction)label6:(id)sender;
- (IBAction)label7:(id)sender;
- (IBAction)label8:(id)sender;
- (IBAction)label9:(id)sender;
- (IBAction)multiply:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)subtract:(id)sender;
- (IBAction)allClear:(id)sender;
- (IBAction)negate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *negate;
@property (weak, nonatomic) IBOutlet UIButton *root;
@property (weak, nonatomic) IBOutlet UIButton *labelAdd;
- (IBAction)label0:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *labelEight;
@property (weak, nonatomic) IBOutlet UIButton *labelNine;
@property (weak, nonatomic) IBOutlet UIButton *labelFour;
@property (weak, nonatomic) IBOutlet UIButton *labelFive;
@property (weak, nonatomic) IBOutlet UIButton *labelSix;
@property (weak, nonatomic) IBOutlet UIButton *labelOne;
@property (weak, nonatomic) IBOutlet UIButton *labelTwo;
@property (weak, nonatomic) IBOutlet UIButton *labelThree;
@property (weak, nonatomic) IBOutlet UIButton *labelZero;
@property (weak, nonatomic) IBOutlet UIButton *labelAC;
@property (weak, nonatomic) IBOutlet UIButton *labelSep;
@property (weak, nonatomic) IBOutlet UIButton *labelMul;
@property (weak, nonatomic) IBOutlet UIButton *labelDiv;
@property (weak, nonatomic) IBOutlet UIButton *labelSub;
- (IBAction)Answer:(id)sender;
- (IBAction)squareRoot:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *labelSeven;
@property (weak, nonatomic) IBOutlet UIButton *labeAns;
- (IBAction)divide:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *screenLabel;
@property aView *a;
@property aView *minus;
@property float nextx;
@property float nexty;
@property float sepx;
@property float sepy;
@property float startOp;
@property int sFlag;
@property NSMutableArray *fractions;
- (IBAction)separator:(id)sender;
-(void)lastsep:(int)size;
-(int)countNumbers:(int)number;
@end

