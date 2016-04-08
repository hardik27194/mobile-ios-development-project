//
//  aView.m
//  FractionalCalculator
//
//  Created by kunal sontakke on 10/18/15.
//  Copyright (c) 2015 kunal sontakke. All rights reserved.
//

#import "Display.h"

@implementation aView

- (void)drawRect:(CGRect)rect 
{
    NSLog(@"hurray--%@",self.text);
     NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:10.0],
                                      NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.text  drawAtPoint:CGPointMake(self.x, self.y) withAttributes:textAttributes];
}



@end
