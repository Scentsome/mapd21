//
//  GrayViewController.m
//  PopoverPresantation
//
//  Created by Michael on 16/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "GrayViewController.h"

@interface GrayViewController ()

@end

@implementation GrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"presenting %@",self.presentingViewController
          );
    NSLog(@"presented %@",self.presentedViewController);
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"===========in GrayViewController");
    NSLog(@"presenting %@",self.presentingViewController
          );
    NSLog(@"presented %@",self.presentedViewController);
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
