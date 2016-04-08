//
//  Time.h
//  kunalSunDemo
//
//  Created by kunal sontakke on 12/12/15.
//  Copyright © 2015 kunal sontakke. All rights reserved.
//

#ifndef Time_h
#define Time_h

@interface sunTime : NSObject
@property (retain, nonatomic) NSNumber* day;
@property (retain, nonatomic) NSNumber* night;
@property (retain, nonatomic) NSNumber* twilight;

+(sunTime *) sharedSingletonInstance;



@end

#endif /* Time_h */
