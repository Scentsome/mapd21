//
//  ViewController.m
//  FireChat
//
//  Created by Michael on 18/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
@import FirebaseAuth;
@interface ViewController ()


@end

@implementation ViewController
- (IBAction)login:(id)sender {
    if (![self.nameField.text isEqualToString:@""]) {
        
        [FIRAuth.auth signInAnonymouslyWithCompletion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                return;
            }
            
            UIViewController * vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"ChatRoomVC"];
            [self presentViewController:vc animated:YES completion:nil];
//            [self performSegueWithIdentifier:@"LoginToChat" sender:nil];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
