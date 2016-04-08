//
//  ViewController.m
//  kunalSunDemo
//
//  Created by kunal sontakke on 12/11/15.
//  Copyright © 2015 kunal sontakke. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "sunTime.h"


#include <stdio.h>
#include <libnova/solar.h>
#include <libnova/julian_day.h>
#include <libnova/rise_set.h>
#include <libnova/transform.h>
int risehr;
int risemin;
float risesec;
int sethr;
int setmin;
float setsec;
float lat;
float lng;
int riseDay;
int riseMonth;
int riseYear;
NSNumber* dayTimeSec;
NSNumber* nightTimeSec;
NSNumber* twilight;
NSString* twilightType;
void print_date (char * title, struct ln_zonedate* date)
{
    printf ("\n%s\n",title);
    printf (" Year    : %d\n", date->years);
    printf (" Month   : %d\n", date->months);
    printf (" Day     : %d\n", date->days);
    printf (" Hours   : %d\n", date->hours);
    printf (" Minutes : %d\n", date->minutes);
    printf (" Seconds : %f\n", date->seconds);
}

void sun()
{
    struct ln_equ_posn equ;
    struct ln_rst_time rst;
    struct ln_zonedate rise, set, transit;
    struct ln_lnlat_posn observer;
    struct ln_helio_posn pos;
    double JD;
    
    /* observers location (Edinburgh), used to calc rst */
    observer.lat = lat; /* 55.92 N */
    observer.lng = lng; /* 3.18 W */
    
    /* get Julian day from local time */
    JD = ln_get_julian_from_sys();
    printf ("JD %f\n", JD);
    
    /* geometric coordinates */
    ln_get_solar_geom_coords (JD, &pos);
    printf("Solar Coords longitude (deg) %f\n", pos.L);
    printf("             latitude (deg) %f\n", pos.B);
    printf("             radius vector (AU) %f\n", pos.R);
    
    /* ra, dec */
    ln_get_solar_equ_coords (JD, &equ);
    printf("Solar Position RA %f\n", equ.ra);
    printf("               DEC %f\n", equ.dec);
    
    /* rise, set and transit */
    if (ln_get_solar_rst (JD, &observer, &rst) == 1)
        printf ("Sun is circumpolar\n");
    else {
        ln_get_local_date (rst.rise, &rise);
        ln_get_local_date (rst.transit, &transit);
        ln_get_local_date (rst.set, &set);
        print_date ("Rise", &rise);
        print_date ("Transit", &transit);
        print_date ("Set", &set);
        
    }
    risehr=rise.hours;
    risemin=rise.minutes;
    risesec=rise.seconds;
    sethr=set.hours;
    setmin=set.minutes;
    setsec=set.seconds;
    riseDay=rise.days;
    riseMonth=rise.months;
    riseYear=rise.years;
    
}

@interface ViewController ()


@end


@implementation ViewController
@synthesize sunChart;
 CLLocationManager *locationManager;


- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    self.pickerData=@[@"Civil",@"Astronomical",@"Nautical"];
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return  [_pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_pickerData objectAtIndex:row];
}

#pragma mark -
#pragma mark PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *resultString = _pickerData[row];
    
    _resultLabel = resultString;
    twilightType=resultString;
    NSLog(@"twilight type:%@",_resultLabel);
}


- (IBAction)refresh:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    sunTime *s;
    s=[sunTime sharedSingletonInstance];
    sun();
    

    
    NSString* rise = [[NSString alloc]initWithFormat:@"%d:%d:%.0f",risehr,risemin,risesec ];
    NSString* set = [[NSString alloc]initWithFormat:@"%d:%d:%.0f",sethr,setmin,setsec ];
    self.riseText.text=rise;
    self.setText.text=set;
    
    dayTimeSec=[[NSNumber alloc]init];
    nightTimeSec=[[NSNumber alloc]init];
    
    
        NSString* firstDateString=[[NSString alloc]initWithFormat:@"%d/%d/%d %d:%d",riseMonth,riseDay,riseYear,risehr,risemin];

        NSString* secondDateString=[[NSString alloc]initWithFormat:@"%d/%d/%d %d:%d",riseMonth,riseDay,riseYear,sethr,setmin];
        
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        // Set the date format according to your needs
        //[df setDateFormat:@"MM/dd/YYYY hh:mm a"]; //for 12 hour format
        [df setDateFormat:@"MM/dd/YYYY HH:mm "];  // for 24 hour format
        NSDate *date1 = [df dateFromString:firstDateString];
        NSDate *date2 = [df dateFromString:secondDateString];
        NSLog(@"%f is the time difference",[date2 timeIntervalSinceDate:date1]);
        
        
        dayTimeSec=[NSNumber numberWithDouble:[date2 timeIntervalSinceDate:date1]];
        
        nightTimeSec=[NSNumber numberWithDouble: 86400-[dayTimeSec doubleValue]];
        
        dayTimeSec=[NSNumber numberWithFloat: (([dayTimeSec floatValue] / 86400))];
        NSLog(@"night sec: %@",nightTimeSec);
        
        nightTimeSec=[NSNumber numberWithFloat: (([nightTimeSec floatValue] / 86400))];
        
        NSLog(@"Calculated day: %@",dayTimeSec);
        NSLog(@"Calculated night: %@",nightTimeSec);
    float temp;
    if ([twilightType  isEqualToString:@"Civil"]) {
        
    
    
        temp=6.0/360.0;
    NSLog(@"temp=%f",temp);
    }
    
    else if ([twilightType  isEqualToString:@"Astronomical"]){
     temp=18.0/360.0;
    
    }
    
    else if ([twilightType  isEqualToString:@"Nautical"]){
         temp=12.0/360.0;
        
    }
    
    else{
        temp=6.0/360.0;
        
    }
    twilight=[NSNumber numberWithFloat:temp];
    nightTimeSec=[NSNumber numberWithFloat:( [nightTimeSec floatValue]-[twilight floatValue]-[twilight floatValue])];
    
        s.day=dayTimeSec;
        s.night=nightTimeSec;
    s.twilight=twilight;

    NSLog(@"day in s:%@",s.day);
    NSLog(@"night in s:%@",s.night);
    NSLog(@"twilight:%@",twilight);
    
//    NSMutableArray *dataArray =[[NSMutableArray alloc]init];
//
//    [dataArray addObject:dayTimeSec];
//    [dataArray addObject:nightTimeSec];
   // [dataArray addObject:nightTimeSec];
    
   // [self.sunChart renderInLayer:self.sunChart dataArray:dataArray];
    PieChart *pieChart = [[PieChart alloc] initWithFrame:CGRectMake(0, 0, sunChart.frame.size.width, sunChart.frame.size.height)];

    pieChart.backgroundColor = [UIColor whiteColor];
    pieChart.transform=CGAffineTransformMakeRotation(-M_PI_2);
    [self.sunChart addSubview:pieChart];

    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
//   // UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//   // [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.lonText.text = [NSString stringWithFormat:@"%.2f", currentLocation.coordinate.longitude];
        self.latText.text = [NSString stringWithFormat:@"%.2f", currentLocation.coordinate.latitude];
       lng= [self.lonText.text floatValue];
       lat= [self.latText.text floatValue];
    }
}
@end
