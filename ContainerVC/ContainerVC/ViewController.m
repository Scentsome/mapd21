//
//  ViewController.m
//  ContainerVC
//
//  Created by Michael on 13/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeVC:(id)sender {
    
    UIViewController * blueVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BlueVC"];
    blueVC.view.frame = CGRectMake(0, 0, 260, 460);
    
    [self addChildViewController:blueVC];
    NSLog(@"%@", self.childViewControllers);
    [self transitionFromViewController:self.childViewControllers[0] toViewController:blueVC duration:1.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        
        
    } completion:^(BOOL stop){
        [blueVC didMoveToParentViewController:self];
        [self.childViewControllers[0] removeFromParentViewController];
        NSLog(@"%@",self.childViewControllers);
    }];
}
- (IBAction)tapHandler:(UITapGestureRecognizer *)sender {
    CGPoint tapPoint = [sender locationInView:self.view];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"began");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"changed");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"end");
            break;
        default:
            break;
    }
    [self changeVC:nil];
}
- (IBAction)longPress:(UILongPressGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"began");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"changed");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"end");
            break;
        default:
            break;
    }
//    NSLog(@"long press");
}
- (IBAction)swipeToUp:(id)sender {
    [self changeVC:nil];
}
- (IBAction)edgeHandler:(UIScreenEdgePanGestureRecognizer *)sender {
    
    self.view.backgroundColor = UIColor.yellowColor;
}


@end
