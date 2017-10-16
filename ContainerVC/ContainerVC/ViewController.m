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
    
    [self transitionFromViewController:self.childViewControllers[0] toViewController:blueVC duration:1.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        [blueVC didMoveToParentViewController:self];
        [self.childViewControllers[0] removeFromParentViewController];
        
    } completion:^(BOOL stop){
        NSLog(@"%@",self.childViewControllers);
    }];
}


@end
