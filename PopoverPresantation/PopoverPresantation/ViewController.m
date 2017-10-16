//
//  ViewController.m
//  PopoverPresantation
//
//  Created by Michael on 16/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
#import "GrayViewController.h"
@interface ViewController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"===========in ViewController");
    NSLog(@"presenting %@",self.presentingViewController
          );
    NSLog(@"presented %@",self.presentedViewController);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"presenting %@",self.presentingViewController
          );
    NSLog(@"presented %@",self.presentedViewController);
}
- (IBAction)showGray:(UIButton *)sender {
    
    GrayViewController * grayVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"GrayVC"];
    
    grayVC.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController * popPC = grayVC.popoverPresentationController;
    
    popPC.sourceRect = sender.frame;
    popPC.sourceView = self.view;
    popPC.permittedArrowDirections = UIPopoverArrowDirectionRight;
    popPC.delegate = self;
    [self presentViewController:grayVC animated:YES completion:nil];

}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return  UIModalPresentationNone;
}


@end
