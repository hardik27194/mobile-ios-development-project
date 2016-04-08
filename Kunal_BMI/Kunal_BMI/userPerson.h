//
//  userPerson.h
//  Kunal_BMI
//
//  Created by kunal sontakke on 9/20/15.
//  Copyright (c) 2015 kunal sontakke. All rights reserved.
//

#ifndef Kunal_BMI_userPerson_h
#define Kunal_BMI_userPerson_h

@interface Singleton : NSObject
@property (retain, nonatomic) NSNumber* height;
@property (retain, nonatomic) NSNumber* weight;
@property (retain, nonatomic) NSNumber* bmi;
@property (retain,nonatomic)NSNumber* unitFlag;
-(NSNumber*) calculateBmi;
+(Singleton *) sharedSingletonInstance;
-(void)unitSwitch;


@end

#endif
