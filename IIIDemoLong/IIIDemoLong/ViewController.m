//
//  ViewController.m
//  IIIDemoLong
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSMutableArray<NSString *> * cars = [@[] mutableCopy];
//
//    NSNumber * num = @8;
//
//    [cars addObject:@"Toyota"];
//    [cars addObject:num];
    UIImagePickerController * picker = [UIImagePickerController new];
    
    picker.delegate = self;
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
