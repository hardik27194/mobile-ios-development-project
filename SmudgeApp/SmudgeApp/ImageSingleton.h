//
//  ImageSingleton.h
//  SmudgeApp
//
//  Created by kunal sontakke on 12/4/15.
//  Copyright © 2015 kunal sontakke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageSingleton : NSObject

@property (retain, nonatomic) NSDictionary* imageInfo;



+(ImageSingleton *) sharedSingletonInstance;



@end
