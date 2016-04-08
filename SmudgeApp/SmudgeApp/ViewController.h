//
//  ViewController.h
//  SmudgeApp
//
//  Created by kunal sontakke on 11/29/15.
//  Copyright © 2015 kunal sontakke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController
- (IBAction)camera:(id)sender;

- (IBAction)selectPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *Image;

@end

