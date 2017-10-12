//
//  ViewController.m
//  IIIDemoLong
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *myButton;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    NSMutableArray<NSString *> * cars = [@[] mutableCopy];
//
//    NSNumber * num = @8;
//
//    [cars addObject:@"Toyota"];
//    [cars addObject:num];
    
    NSDictionary * json = @{
        @"time": @"03:53:25 AM",
        @"milliseconds_since_epoch": @1362196405309,
        @"date": @"03-02-2013"
        };
    for ( NSString * key in json.allKeys ){
        
        id value = json[key];
    }
    
    [json enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
    }];
    
    NSArray * testArray = [NSArray arrayWithObjects:@"one", @"two", @"three",@"four",@"five",nil];
    
    [testArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@", obj);
    }];
    
    NSLog(@"%@",self.view);
//    NSLog(@"%@",view);
    
    [self.myButton addTarget:self action:@selector(hello:event:) forControlEvents:UIControlEventTouchUpInside];
}
-(void) hello{
    NSLog(@"hello");
}

-(void) hello:(UIButton *) sender {
    NSLog(@"hello sender");
}

-(void) hello:(UIButton *) sender  event:(UIEvent *) event{
    NSLog(@"hello sender event");
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)stepper:(UIStepper *)sender {
    NSLog(@"%f",sender.value);
}
- (IBAction)swipeToRight:(id)sender {
    
    NSLog(@"Swipe");
}


@end
