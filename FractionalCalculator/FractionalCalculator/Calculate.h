//
//  CalculateEngine.h
//  FractionalCalculator
//
//  Created by kunal sontakke on 10/18/15.
//  Copyright (c) 2015 kunal sontakke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FractionHandler.h"
@interface Calculate : NSObject
@property NSMutableArray *operands;
@property NSMutableArray *operators;
@property NSMutableArray *postfixNotaion;


-(NSMutableArray*)convertToPostfix:(NSMutableArray*)infix;
-(BOOL)checkPriority:(NSString*)o1 secondOp:(NSString*)o2;
-(int)getPriority:(NSString*)operator;
-(Fraction*)calculate;

@end
