//
//  ViewController.m
//  PredictImage
//
//  Created by Michael on 12/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
@import CoreML;
#import "Inceptionv3.h"


@interface ViewController (){
    Inceptionv3 * model;
}




@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *possibleDesc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [Inceptionv3 new];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)guess:(id)sender {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(299,299), true, 2.0);
    [self.imageView.image drawInRect:CGRectMake(0, 0,  299, 299)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:(NSString*)kCVPixelBufferCGImageCompatibilityKey, kCFBooleanTrue,(NSString *)kCVPixelBufferCGBitmapContextCompatibilityKey,kCFBooleanTrue, nil];
    
    CVPixelBufferRef  pixelBuffer = NULL;
    CVReturn status =  CVPixelBufferCreate(kCFAllocatorDefault, (NSInteger)newImage.size.width, (NSInteger)newImage.size.height,                                   kCVPixelFormatType_32BGRA,  (__bridge CFDictionaryRef)attrs, &pixelBuffer);
    
    if (status !=  kCVReturnSuccess ){
        NSLog(@"=== error status %d",status);
        return;
    }
    
    CVPixelBufferLockBaseAddress(pixelBuffer, kCVPixelBufferLock_ReadOnly);
    void * pixelData = CVPixelBufferGetBaseAddress(pixelBuffer);
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate( pixelData,  (NSInteger)newImage.size.width,  (NSInteger)newImage.size.height,                                               8,CVPixelBufferGetBytesPerRow(pixelBuffer),rgbColorSpace,  kCGImageAlphaNoneSkipFirst) ;
    CGContextTranslateCTM(context,0,newImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    UIGraphicsPushContext(context);
    
    [newImage drawInRect:CGRectMake( 0,  0, newImage.size.width,  newImage.size.height)];
    
    UIGraphicsPopContext();
    CVPixelBufferUnlockBaseAddress(pixelBuffer, kCGImageAlphaNoneSkipFirst);
    self.imageView.image = newImage;
    
    NSError * error = nil;
    Inceptionv3Output * result = [model predictionFromImage:pixelBuffer error:&error];
    self.possibleDesc.text = result.classLabel;
    NSLog(@"==========%@",result.classLabel);
    
}


@end
