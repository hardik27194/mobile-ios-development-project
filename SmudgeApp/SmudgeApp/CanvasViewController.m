//
//  CanvasViewController.m
//  SmudgeApp
//
//  Created by kunal sontakke on 12/3/15.
//  Copyright © 2015 kunal sontakke. All rights reserved.
//

#import "CanvasViewController.h"
#import "ImageSingleton.h"
float r1=10;
float r2=10;
float cr=5;
ImageSingleton* dictionary;
@interface CanvasViewController ()

@end

@implementation CanvasViewController

UIColor* smudgeColor;
@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:panGesture];
    
    
    dictionary = [ImageSingleton sharedSingletonInstance];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [dictionary.imageInfo objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%@", [dictionary.imageInfo objectForKey:UIImagePickerControllerOriginalImage]);
    NSLog(@"%@", self.imageView.image);
    self.imageView.frame = [self.view bounds];
    [self.view addSubview:self.imageView];
    
    

}
-(void)handlePanGesture:(UIGestureRecognizer*) recognizer {
    
    
    if(self.imageView.image != nil) {
        

        
        
        if(recognizer.state == UIGestureRecognizerStateBegan) {
            
            NSLog(@"pan gesture just started");
            CGPoint location = [recognizer locationInView:self.imageView];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
                smudgeColor = [self getPixelColorAtLocation:CGPointMake(location
                                                                        .x , location.y) withImage:self.imageView.image];
            });
           
            r1=20;
            r2=20;
            cr=10;
        }
        
        if(recognizer.state == UIGestureRecognizerStateChanged) {
//            CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//            [filter setValue:self.imageView.image forKey:kCIInputImageKey];
//            [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
//            CIImage *result = [filter valueForKey:kCIOutputImageKey];
            NSLog(@"pan gesture state changing");
           CGPoint location = [recognizer locationInView:self.imageView];
            UIView* a = [[UIView alloc]init];
            a.frame = CGRectMake(location.x, location.y, r1, r2);
            a.layer.cornerRadius = r1/2;
            a.layer.masksToBounds = YES;
            a.backgroundColor = smudgeColor;
           //  a.backgroundColor = nil;
            //a.layer.shadowOpacity = 0.5;
            
            [self.view.layer addSublayer:a.layer];
            [self.view addSubview:a];
            //self.view.backgroundColor = smudgeColor;
            r1=r1-0.25;
            r2=r2-0.25;
            cr=cr-0.25;
            if (r1<=0||r2<=0||cr<=0){
                r1=0;
                r2=0;
                cr=0;
            }
           // NSLog(@"r1:%f r2:%f cr:%f",r1,r2,cr);
        }
        
        if(recognizer.state == UIGestureRecognizerStateEnded) {
            
            smudgeColor = nil;
        }
      
        

        
    }
    
}

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    

    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);

    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);

    colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }

    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    

    context = CGBitmapContextCreate (bitmapData,pixelsWide,pixelsHigh,8,bitmapBytesPerRow,colorSpace,kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    

    CGColorSpaceRelease( colorSpace );
    
    return context;
}

- (UIColor*) getPixelColorAtLocation:(CGPoint)point withImage:(UIImage*)image {
    UIColor* color = nil;
    CGImageRef inImage = image.CGImage;

    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) { return nil; /* error */ }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    size_t bytesPerRow = CGImageGetBytesPerRow(inImage);
    size_t bytesPerPixel = bytesPerRow / w;
    NSLog(@"%zu %zu %zu", w,h, bytesPerPixel);
    CGRect rect = {{0,0},{w,h}};
    

    CGContextDrawImage(cgctx, rect, inImage);
    

    unsigned char* data = CGBitmapContextGetData (cgctx);
    float xscale = w / self.imageView.frame.size.width;
    float yscale = h / self.imageView.frame.size.height;
//    point.x = point.x * xscale;
//    point.y = point.y * yscale;
    if (data != NULL) {
        //offset locates the pixel in the data from x,y.
        //4 for 4 bytes of data per pixel, w is width of one row of data.
        NSLog(@"%f %f %fscale is", self.image.scale, xscale, yscale);
        int offset = 4*((w*round(point.y * yscale))+round(point.x * xscale))*self.image.scale;
        //int pixelInfo = ((image.size.width  * point.y) + point.x) * 4;
      //  NSLog(@" offset is %d", offset);
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
//        int alpha = data[pixelInfo];
//        int red = data[pixelInfo+1];
//        int green = data[pixelInfo+2];
//        int blue = data[pixelInfo+3];
        NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
        NSLog(@"-----------------------");
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
//        UIView* view = [[UIView alloc]init];
//        view.frame = CGRectMake(0, 0, 100, 100);
//        view.backgroundColor = color;
//        [self.view addSubview:view];
    }
    

    CGContextRelease(cgctx);

    if (data) { free(data); }
    
    return color;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
