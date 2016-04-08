//
//  userPerson.m
//  Kunal_BMI
//
//  Created by kunal sontakke on 9/20/15.
//  Copyright (c) 2015 kunal sontakke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userPerson.h"

static Singleton* _sharedSingletonInstance;
@implementation Singleton
@synthesize height;
@synthesize weight;
@synthesize bmi;
@synthesize unitFlag;

-(Singleton*) init
{
    self = [super init];
    if( self ){
        self.unitFlag=@1;
    }
    return self;
}
//calculate BMI
-(NSNumber*) calculateBmi
{
    if([self.unitFlag isEqual:@0]){
        self.height=[NSNumber numberWithFloat:([self.height floatValue]/100)];
        
      //  NSLog(@"height in meter:%@",self.height);
    float temp = ([self.weight floatValue])/([self.height floatValue]*[self.height floatValue]);
    self.bmi= [NSNumber numberWithFloat:temp];
      //  NSLog(@"BMI cm/kg:%@",self.bmi);
    return self.bmi;
    }
    
    else{
        float temp =703* ([self.weight floatValue])/([self.height floatValue]*[self.height floatValue]);
        self.bmi= [NSNumber numberWithFloat:temp];
       // NSLog(@"BMI in/lbs:%@",self.bmi);
        return self.bmi;
        
    }
}
//Unit Conversions
-(void)unitSwitch{
    //Convert cm to in. and kg to lbs.
    if( [self.unitFlag isEqual:@0]){
        float tempHeight=([self.height floatValue]*2.54);
        
        self.height= [NSNumber numberWithFloat:tempHeight];
        
        float tempweight=([self.weight floatValue]*0.453592);
        
        self.weight= [NSNumber numberWithFloat:tempweight];
        
        
    }
    //Convert in. to cm and lbs. to kg
    else{
        float tempHeight=([self.height floatValue]/2.54);
        
        self.height= [NSNumber numberWithFloat:tempHeight];
        
        float tempweight=([self.weight floatValue]/0.453592);
        
        self.weight= [NSNumber numberWithFloat:tempweight];
    }
    
}
/*

+(void) initialize
{
    if( [Singleton class] == self ){
        _sharedSingletonInstance = [self new];
    }
}*/

+(Singleton*) sharedSingletonInstance
{
    if(_sharedSingletonInstance != nil){
    

    return _sharedSingletonInstance;
}
    else{
        _sharedSingletonInstance=[[Singleton alloc]init];
        return _sharedSingletonInstance;
    }
}

+(id) allocWithZone: (NSZone*) aZone
{
    if( _sharedSingletonInstance && [Singleton class] == self ){
        [NSException raise: NSGenericException format: @"May not create more than one instance of a singleton class!"];
    }
    return [super allocWithZone: aZone];
}

@end


