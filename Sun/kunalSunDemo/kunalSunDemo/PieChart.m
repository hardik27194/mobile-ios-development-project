//
//  PieChart.m
//  KunalSunDemo
//
//  Created by Kunal Sontakke on 12/12/15.
//  Copyright © 2015 Kunal Sontakke. All rights reserved.
//

#import "PieChart.h"
#import "sunTime.h"

@implementation PieChart

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize circleRadius = _circleRadius;
@synthesize sliceArray = _sliceArray;
@synthesize colorsArray = _colorsArray;
@synthesize day;
@synthesize night;
@synthesize twilight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set up the slices
     
        
        // Set up the colors for the slices
        NSArray *colors = [NSArray arrayWithObjects:(id)[UIColor orangeColor].CGColor,
                           (id)[UIColor yellowColor].CGColor,
                           (id)[UIColor orangeColor].CGColor,
                           (id)[UIColor blackColor].CGColor, nil];
        self.colorsArray = colors;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawPieChart:context];
}


- (void)drawPieChart:(CGContextRef)context  {
    
    
    sunTime *s=[sunTime sharedSingletonInstance];
    day=s.day;
    night=s.night;
    twilight=s.twilight;
    
    
    
    NSArray *slices = [NSArray arrayWithObjects:[NSNumber numberWithFloat:[twilight floatValue]],
                       [NSNumber numberWithFloat:[day floatValue]],[NSNumber numberWithFloat:[twilight floatValue]],
                       [NSNumber numberWithFloat:[night floatValue]],
                       nil];
    
    
    self.sliceArray = slices;
    self.sliceArray = slices;

    CGPoint circleCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    // Set the radius of your pie chart
    self.circleRadius = 70;
    
    for (NSUInteger i = 0; i < [_sliceArray count]; i++) {
        
        // Determine start angle
        CGFloat startValue = 0;
        for (int k = 0; k < i; k++) {
            startValue += [[_sliceArray objectAtIndex:k] floatValue];
        }
        CGFloat startAngle = startValue * 2 * M_PI - M_PI/2;
        
        // Determine end angle
        CGFloat endValue = 0;
        for (int j = i; j >= 0; j--) {
            endValue += [[_sliceArray objectAtIndex:j] floatValue];
        }
        CGFloat endAngle = endValue * 2 * M_PI - M_PI/2;
        
        CGContextSetFillColorWithColor(context, (CGColorRef)[_colorsArray objectAtIndex:i]);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
        CGContextAddArc(context, circleCenter.x, circleCenter.y, self.circleRadius, startAngle, endAngle, 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
    }
}
@end
