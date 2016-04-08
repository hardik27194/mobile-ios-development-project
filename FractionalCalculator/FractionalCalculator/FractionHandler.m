//
//  Fraction.m
//  FractionalCalculator
//
//  Created by kunal sontakke on 10/18/15.
//  Copyright (c) 2015 kunal sontakke. All rights reserved.
//

#import "FractionHandler.h"
#import <math.h>
@implementation Fraction
-(Fraction*)add:(Fraction*)op2
{
    Fraction *result = [[Fraction alloc]init];
    if(self.denominator==op2.denominator)
    {
        result.denominator = self.denominator;
        result.numerator = self.numerator + op2.numerator;
        if( result.numerator!=0 && result.denominator!=0)
        {

        if(result.numerator%result.denominator==0)
        {
            result.numerator = result.numerator/result.denominator;
            result.denominator=1;
            
        }
        if(result.denominator%result.numerator==0)
        {
            result.denominator= result.denominator/result.numerator;
            result.numerator=1;
            
        }
        }
        return result;
    }
    else
    {
        int a, b, x, y, temp, gcd, lcm;
        
        
        x= self.denominator;
        y= op2.denominator;
        a = x;
        b = y;
        
        while (b != 0) {
            temp = b;
            b = a % b;
            a = temp;
        }
        
        gcd = a;
        lcm = (x*y)/gcd;
        

        result.numerator = (self.numerator*(lcm/self.denominator)) + (op2.numerator*(lcm/op2.denominator));
       
        result.denominator = lcm;
        if(result.numerator%result.denominator==0)
        {
            result.numerator = result.numerator/result.denominator;
            result.denominator=1;
            
        }
        if(result.denominator%result.numerator==0)
        {
            result.denominator= result.denominator/result.numerator;
            result.numerator=1;
            
        }

        return result;
    }
    
}
-(Fraction*)subtract:(Fraction*)op2
{
    Fraction *result = [[Fraction alloc]init];
    if(self.denominator==op2.denominator)
    {
        result.denominator = self.denominator;
        result.numerator = self.numerator - op2.numerator;
        if( result.numerator!=0 && result.denominator!=0)
        {

        if(result.numerator%result.denominator==0 && result.numerator!=0)
        {
            result.numerator = result.numerator/result.denominator;
            result.denominator=1;
            
        }
        if(result.denominator%result.numerator==0 && result.numerator!=0)
        {
            result.denominator= result.denominator/result.numerator;
            result.numerator=1;
            
        }
        }
        return result;
    }
    else
    {
        int a, b, x, y, temp, gcd, lcm;
        
        
        x= self.denominator;
        y= op2.denominator;
        a = x;
        b = y;
        
        while (b != 0) {
            temp = b;
            b = a % b;
            a = temp;
        }
        
        gcd = a;
        lcm = (x*y)/gcd;
        
        result.numerator = (self.numerator*(lcm/self.denominator)) - (op2.numerator*(lcm/op2.denominator));
        result.denominator = lcm;
        
        if(result.numerator%result.denominator==0 && result.numerator!=0)
        {
            result.numerator = result.numerator/result.denominator;
            result.denominator=1;
           
            
        }
        if(result.denominator%result.numerator==0 && result.numerator!=0)
        {
            result.denominator= result.denominator/result.numerator;
            result.numerator=1;
            
        }

        return result;

    }

    
}
-(Fraction*)divide:(Fraction*)op2
{
     Fraction *result = [[Fraction alloc]init];
     result.numerator = (self.numerator)*(op2.denominator);
     result.denominator = (self.denominator)*(op2.numerator);
    if( result.numerator!=0 && result.denominator!=0)
    {
    if(result.numerator%result.denominator==0)
    {
        result.numerator = result.numerator/result.denominator;
        result.denominator=1;
        
    }
    if(result.denominator%result.numerator==0)
    {
        result.denominator= result.denominator/result.numerator;
        result.numerator=1;
        
    }
    }
    return result;
    
}
-(Fraction*)multiply:(Fraction*)op2
{
    Fraction *result = [[Fraction alloc]init];
    result.numerator = (self.numerator)*(op2.numerator);
    result.denominator = (self.denominator)*(op2.denominator);
    if( result.numerator!=0 && result.denominator!=0)
    {

    if(result.numerator%result.denominator==0 && result.numerator!=0)
    {
        result.numerator = result.numerator/result.denominator;
        result.denominator=1;
        
    }
    if(result.denominator%result.numerator==0 && result.numerator!=0)
    {
        result.denominator= result.denominator/result.numerator;
        result.numerator=1;
        
    }
    }
    return result;

    
}
-(NSMutableDictionary*)squareRoot:(Fraction*)op2
{
    NSMutableDictionary *final = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *rootOfNumerator = [self findRoot:op2.numerator];
    
    int numeratorPartOne=1;
    int numeratorPartTwo =1;
   
   for(id key in rootOfNumerator)
   {
       double result;
       
       if([[rootOfNumerator objectForKey:key] intValue]%2==0)
       {
            result = sqrt(pow([key intValue], [[rootOfNumerator objectForKey:key] intValue]));
            numeratorPartOne = numeratorPartOne*result;
       }
       else
       {
           if(([[rootOfNumerator objectForKey:key] intValue]-1) != 0)
           {
               result = sqrt(pow([key intValue], ([[rootOfNumerator objectForKey:key] intValue])-1));
               numeratorPartOne = numeratorPartOne*result;
               numeratorPartTwo = numeratorPartTwo*[key intValue];
           }
           else
           {
               numeratorPartTwo = numeratorPartTwo*[key intValue];
           }
       }
   }
    [final setObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:numeratorPartOne],[NSNumber numberWithInt:numeratorPartTwo], nil] forKey:@"numerator"];
    NSMutableDictionary *rootOfDenominator = [self findRoot:op2.denominator];
    int denominatorPartOne=1;
    int denominatorPartTwo =1;
    
    for(id key in rootOfDenominator)
    {
        double result;
        
        if([[rootOfDenominator objectForKey:key] intValue]%2==0)
        {
            result = sqrt(pow([key intValue], [[rootOfDenominator objectForKey:key] intValue]));
            denominatorPartOne= denominatorPartOne*result;
        }
        else
        {
            if(([[rootOfDenominator objectForKey:key] intValue]-1) != 0)
            {
             result = sqrt(pow([key intValue], ([[rootOfDenominator objectForKey:key] intValue])-1));
             denominatorPartOne = denominatorPartOne*result;
             denominatorPartTwo = denominatorPartTwo*[key intValue];
            }
            else
            {
                denominatorPartTwo = denominatorPartTwo*[key intValue];
            }
            
        }
    }
     [final setObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:denominatorPartOne],[NSNumber numberWithInt:denominatorPartTwo], nil] forKey:@"denominator"];
  
    return final;
}

-(NSMutableDictionary*)findRoot:(int)num
{
    
    NSMutableArray* allprime = [[NSMutableArray alloc]initWithObjects:nil];
    for(int i=2;i<=num;i++)
    {
        
        if((num%i)==0)
        {
            
            int q = i;
            int count=0;
            for(int j=1;j<=q;j++)
            {
                if(q%j==0)
                    count++;
            }
            if(count==2)
            {
                [allprime addObject:[NSNumber numberWithInt:q]];
            }
            
            
        }
    
    }
    
    NSMutableDictionary *final = [[NSMutableDictionary alloc]init];
    for(NSNumber *i in allprime)
    {
        int count=0;
        int q=[i intValue];
        int number = num;
        while(YES)
        {
            if(number%q==0)
            {
                
                count++;
                number = number/q;
            }
            else
            {
                
                break;
            }
        }
        
        [final setObject:[NSNumber numberWithInt:count] forKey:[NSNumber numberWithInt:q]];
        
        
    }
    
    
    return final;
}
    

@end


