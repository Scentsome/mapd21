//
//  ViewController.m
//  FetchModeDemo
//
//  Created by Michael on 13/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)download:(id)sender {
    
    NSURL * url = [NSURL URLWithString:@"https://c2.staticflickr.com/8/7342/9923653053_1cec54d89c_b.jpg"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:data];
        });
        
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) performFetchHandler:(void (^)(UIBackgroundFetchResult)) completionHandler{
    completionHandler(UIBackgroundFetchResultNewData);
    //    completionHandler(UIBackgroundFetchResultNoData);
    NSString* sessionID = [@"com.zencher.backgroundsession." stringByAppendingFormat:@"%d", 34];
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:sessionID];
    NSURLSession * urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString * urlString = @"https://c2.staticflickr.com/8/7342/9923653053_1cec54d89c_b.jpg";
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask * downloadTask = [urlSession downloadTaskWithRequest:request];
    [downloadTask resume];
    
    
}

-(void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"%@",location.absoluteString);
    NSData * data = [NSData dataWithContentsOfURL:location];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData:data];
//        self.stateLabel.text = @"Done";
    });
    
}

@end
