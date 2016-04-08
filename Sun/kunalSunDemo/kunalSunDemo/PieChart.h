//
//  PieChart.h
//  KunalSunDemo
//
//  Created by Kunal Sontakke on 12/12/15.
//  Copyright © 2015 Kunal Sontakke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChart : UIView


@property (nonatomic, assign) CGFloat circleRadius;
@property (nonatomic, retain) NSArray *sliceArray;
@property (nonatomic, retain) NSArray *colorsArray;
@property (nonatomic,retain)NSNumber *day;
@property(nonatomic,retain)NSNumber *night;
@property (nonatomic,retain)NSNumber *twilight;

- (void)drawPieChart:(CGContextRef)context;

@end
