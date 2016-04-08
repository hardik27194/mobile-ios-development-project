//
//  ViewController.m
//  Kunal_BMI
//
//  Created by kunal sontakke on 9/19/15.
//  Copyright (c) 2015 kunal sontakke. All rights reserved.
//

#import "ViewController.h"
#import "userPerson.h"

@interface ViewController ()


@end

@implementation ViewController

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.heightText resignFirstResponder];
    [self.weightText resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Unit Conversions
- (IBAction)unitSwitch:(id)sender {
    Singleton* unit;
    unit= [Singleton sharedSingletonInstance];
    
    NSString *str =[self.heightText text];
    unit.height = [NSNumber numberWithFloat:[str floatValue]];
    
    NSString *str1 =[self.weightText text];
    unit.weight = [NSNumber numberWithFloat:[str1 floatValue]];
    
    if ([sender isOn]) {
        
        unit.unitFlag=@1;
        
        [unit unitSwitch];
        self.heightText.text= [NSString stringWithFormat:@"%@",unit.height];
        self.weightText.text= [NSString stringWithFormat:@"%@",unit.weight];
        self.heightDim.text= @"in.";
        self.weightDim.text=@"lbs.";
      
        
        
        
        
    }
    else
    {
        unit.unitFlag=@0;
        [unit unitSwitch];
        self.heightText.text= [NSString stringWithFormat:@"%@",unit.height];
        self.weightText.text= [NSString stringWithFormat:@"%@",unit.weight];
        self.heightDim.text=@"cm.";
        self.weightDim.text=@"kg.";
        
        
    }
    
}
//Calculate BMI
- (IBAction)calculate:(id)sender {
    
    Singleton* s ;
    s= [Singleton sharedSingletonInstance];
    
    NSString *str =[self.heightText text];
    s.height = [NSNumber numberWithFloat:[str floatValue]];
    
    
    NSString *str1 = [self.weightText text];
    s.weight = [NSNumber numberWithFloat:[str1 floatValue]];
   
    
    
    
    NSNumber * q = [s calculateBmi];


    
    self.bmi.text=[NSString stringWithFormat:@"%@",q];
    self.bmi.hidden=NO;
    self.bmiDesc.hidden=NO;
    
    UIImage *bmiImage;
    if([q doubleValue]< 16.00)
    {
        
        self.bmiDesc.text = @"severe thinness";
        bmiImage = [UIImage imageNamed: @"1.png"];
        self.image.image = bmiImage;
        
    }
    else if([q doubleValue] <=16.00 && [q doubleValue]<16.99)
    {
        self.bmiDesc.text = @"Moderate thinness";
        bmiImage = [UIImage imageNamed: @"2.png"];
        self.image.image = bmiImage;
    }
    else if([q doubleValue] >=17.00 && [q doubleValue]<18.49)
    {
        self.bmiDesc.text = @"Mild thinness";
       bmiImage = [UIImage imageNamed: @"3.png"];
        self.image.image = bmiImage;
    }
    else if([q doubleValue] >=18.50 &&[q doubleValue]<24.99)
    {
        self.bmiDesc.text = @"Normal Range";
      
        bmiImage = [UIImage imageNamed: @"4.png"];
        self.image.image = bmiImage;
    }
    else if([q doubleValue] >=25.00 && [q doubleValue]<29.99)
    {
        self.bmiDesc.text = @"OverWeight";
        bmiImage = [UIImage imageNamed: @"5.png"];
        self.image.image = bmiImage;
    }
    else if([q doubleValue] >=30.00 && [q doubleValue]<34.99)
    {
        self.bmiDesc.text = @"Obese class I(Moderate)";
        bmiImage = [UIImage imageNamed: @"6.png"];
        self.image.image = bmiImage;
    }
    else if([q doubleValue] >=35.00 && [q doubleValue]<39.99)
    {
        self.bmiDesc.text = @"Obese class II(Severe)";
        bmiImage = [UIImage imageNamed: @"7.png"];
         self.image.image = bmiImage;
    }
    else if([q doubleValue]>=39.99)
    {
        self.bmiDesc.text = @"Obese class III(Very Severe)";
        bmiImage = [UIImage imageNamed: @"8.png"];
         self.image.image = bmiImage;
    }
    
    
    
}
@end
