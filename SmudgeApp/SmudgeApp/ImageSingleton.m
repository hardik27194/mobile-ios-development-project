//
//  ImageSingleton.m
//  SmudgeApp
//
//  Created by kunal sontakke on 12/4/15.
//  Copyright © 2015 kunal sontakke. All rights reserved.
//

#import "ImageSingleton.h"



static ImageSingleton* _sharedSingletonInstance;
@implementation ImageSingleton


-(ImageSingleton*) init
{
    self = [super init];
    if( self ){
       
    }
    return self;
}

+(ImageSingleton*) sharedSingletonInstance
{
    if(_sharedSingletonInstance != nil){
        
        
        return _sharedSingletonInstance;
    }
    else{
        _sharedSingletonInstance=[[ImageSingleton alloc]init];
        return _sharedSingletonInstance;
    }
}

+(id) allocWithZone: (NSZone*) aZone
{
    if( _sharedSingletonInstance && [ImageSingleton class] == self ){
        [NSException raise: NSGenericException format: @"May not create more than one instance of a singleton class!"];
    }
    return [super allocWithZone: aZone];
}
@end
