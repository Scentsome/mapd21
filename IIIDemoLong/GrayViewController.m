//
//  GrayViewController.m
//  IIIDemoLong
//
//  Created by Michael on 12/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "GrayViewController.h"

@interface GrayViewController ()

@end

@implementation GrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.childViewControllers);
   
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    UIViewController * pinkVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PinkVC"];
//    [self presentViewController:pinkVC animated:YES completion:nil];
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
-(IBAction)  home:(UIStoryboardSegue *)sender{
    
}
- (IBAction)changeDate:(UIDatePicker *)sender {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];

    NSDate * date = sender.date;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"%@",[formatter stringFromDate:date]);
}

@end
