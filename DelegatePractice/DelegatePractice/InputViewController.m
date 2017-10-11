//
//  InputViewController.m
//  DelegatePractice
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "InputViewController.h"


@interface InputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@end

@implementation InputViewController
- (IBAction)sendData:(id)sender {
//    [self.delegate inputDidEnterText:self.inputField.text];
self.dataBlock(self.inputField.text);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
