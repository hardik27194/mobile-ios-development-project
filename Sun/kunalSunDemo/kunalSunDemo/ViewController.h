//
//  ViewController.h
//  kunalSunDemo
//
//  Created by kunal sontakke on 12/11/15.
//  Copyright © 2015 kunal sontakke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChart.h"
@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,CLLocationManagerDelegate>




@property (weak, nonatomic) IBOutlet UIPickerView *typePicker;
@property (strong,nonatomic) NSArray* pickerData;
@property(strong,nonatomic) NSString* resultLabel;


@property (weak, nonatomic) IBOutlet UILabel *riseText;
@property (weak, nonatomic) IBOutlet UILabel *setText;

@property (nonatomic,retain) IBOutlet PieChart * sunChart;
- (IBAction)refresh:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *latText;
@property (weak, nonatomic) IBOutlet UILabel *lonText;

@property (strong, nonatomic)NSDate* day;


@end

