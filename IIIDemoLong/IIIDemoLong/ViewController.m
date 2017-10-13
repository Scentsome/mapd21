//
//  ViewController.m
//  IIIDemoLong
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
#import "DrawPad.h"

#define BLUEVIEW 22

@interface ViewController ()<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet DrawPad *grayView;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@end

@implementation ViewController{
//    UIView * blueView ;
}

- (IBAction)showPink:(id)sender {
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.inputField becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.grayView.frame = CGRectMake(100, 200, 30, 30);
    
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
    
//    [self.myButton addTarget:self action:@selector(hello:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"did enter background");
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"%@",note);
    }];
}
-(void) hello{
    NSLog(@"hello");
}

-(void) hello:(UIButton *) sender {
    NSLog(@"hello sender");
}

//-(void) hello:(UIButton *) sender  event:(UIEvent *) event{
//    NSLog(@"hello sender event");
//
//    UIStoryboard * story = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
//
//    UIViewController * initVC = [story instantiateInitialViewController];
//
//    [self presentViewController:initVC animated:YES completion:nil];
//}
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
- (IBAction)addView:(id)sender {
    
    UIView * blueView = [UIView new];
    blueView.tag = BLUEVIEW;
    blueView.frame = CGRectMake(50, 50, 100, 30);
    
    blueView.backgroundColor = UIColor.blueColor;
    
    [self.view addSubview:blueView];
}
- (IBAction)removeView:(id)sender {
//    [blueView removeFromSuperview];
    UIView * blueView = [self.view viewWithTag:BLUEVIEW];
    
    [blueView removeFromSuperview];
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touched in view controller");
//}
- (IBAction)moveView:(id)sender {
    
    
    [UIView animateWithDuration:1.0 animations:^{
        self.grayView.center = CGPointMake(50,50);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.grayView.center = CGPointMake(100,100);
        }];
        
    }];
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    NSLog(@"change orientation");
    if(size.height > size.width){
        NSLog(@"Vertical");
    }else {
        NSLog(@"Landscape");
    }
}

//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscape;
//}

@end
