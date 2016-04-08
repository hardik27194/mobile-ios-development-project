//
//  CalculateEngine.m
//  FractionalCalculator
//
//  Created by kunal sontakke on 10/18/15.
//  Copyright (c) 2015 kunal sontakke. All rights reserved.
//

#import "Calculate.h"
@implementation Calculate
-(id)init
{
    
    self=[super init];
    if(self)
    {
        
         self.operators=[[NSMutableArray alloc]initWithObjects:nil];
         self.operands=[[NSMutableArray alloc]initWithObjects:nil];
        
    }
    
    return self;
    
}
-(NSMutableArray*)convertToPostfix:(NSMutableArray*)infix
{
    NSMutableArray *postfix = [[NSMutableArray alloc]initWithObjects: nil];
    NSString* temp2 ;
    for(id i in infix)
    {
        if([i isKindOfClass:[Fraction class]])
        {
            [postfix addObject:i];
            
        }
        
        else{
           

           temp2 = (NSString*)i;
            if([self.operators count]!=0)
            {
                while(YES)
            
                {
                    if([self.operators count]==0)
                    {
                        break;
                    }
                    NSString* temp1 = [self.operators objectAtIndex:([self.operators count]-1)];
                   
                
                    if([self checkPriority:temp2 secondOp:temp1])
                    {
                        
                        [postfix addObject:temp1];
                        [self.operators removeLastObject];
                    
                    }
                    else
                    {
                    
                        break;
                    }
                }
            }
           
            [self.operators addObject:i];

        }
        
        
        
    }
    for(int i=[self.operators count];i>0;i--)
    {
        NSLog(@"emptyng stack");

        [postfix addObject:[self.operators objectAtIndex:i-1]];
    }
    
    self.postfixNotaion = postfix;
    
    return postfix;
}

-(BOOL)checkPriority:(NSString*)o1 secondOp:(NSString*)o2
{
    
    if([self getPriority:o1]<[self getPriority:o2])
    {
        return YES;
        
    }
    else
    {
        return NO;
    }
    
}

-(int)getPriority:(NSString*)operator
{
    if([operator isEqualToString:@"*"] || [operator isEqualToString:@"/"])
    {
        
        return 2;
    }
    if([operator isEqualToString:@"+"] || [operator isEqualToString:@"-"])
    {
        
        return 1;
    }
    return 0;
    
}

-(Fraction*)calculate
{
    Fraction *result;
    NSMutableArray *process=[[NSMutableArray alloc]initWithObjects:nil];
       for (id i in self.postfixNotaion)
       {
           if([i isKindOfClass:[Fraction class]])
           {
               
               [process addObject:i];
               
           }
           else
           {
               
               Fraction *f1 = [process objectAtIndex:[process count]-1];
               Fraction *f2 = [process objectAtIndex:[process count]-2];
               [process removeLastObject];
               [process removeLastObject];
               
               if([(NSString*)i isEqualToString:@"+"])
                   result = [f1 add:f2];
               else if ([(NSString*)i isEqualToString:@"-"])
                    result = [f2 subtract:f1];
               else if ([(NSString*)i isEqualToString:@"/"])
                   result = [f2 divide:f1];
               else
                    result = [f1 multiply:f2];
              
               
               [process addObject:result];
               
           }

       }
    return result;
}

@end
