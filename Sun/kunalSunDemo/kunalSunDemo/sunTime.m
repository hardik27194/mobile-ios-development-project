//
//  Time.m
//  kunalSunDemo
//
//  Created by kunal sontakke on 12/12/15.
//  Copyright © 2015 kunal sontakke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sunTime.h"

static sunTime* _sharedSingletonInstance;
@implementation sunTime
@synthesize day;
@synthesize night;
@synthesize twilight;

-(sunTime*) init
{
    self = [super init];
    if( self ){
       
    }
    return self;
}

+(sunTime*) sharedSingletonInstance
{
    if(_sharedSingletonInstance != nil){
        
        
        return _sharedSingletonInstance;
    }
    else{
        _sharedSingletonInstance=[[sunTime alloc]init];
        return _sharedSingletonInstance;
    }
}

+(id) allocWithZone: (NSZone*) aZone
{
    if( _sharedSingletonInstance && [sunTime class] == self ){
        [NSException raise: NSGenericException format: @"May not create more than one instance of a singleton class!"];
    }
    return [super allocWithZone: aZone];
}

@end