//
//  ViewController.m
//  DelegatePractice
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
#import "InputViewController.h"

//typedef   int  (^ MYBLOCK) (int,int);

@interface ViewController()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController


//-(void) funcBlock:(MYBLOCK) myBlock{
////    myBlock(8,9);
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.myBlock = ^int(int a, int b) {
//        return a + b;
//    };
//    [self funcBlock:self.myBlock];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)inputDidEnterText:(NSString *)inputString {
//    self.resultLabel.text = inputString;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    InputViewController * inputVC =  segue.destinationViewController;
//    inputVC.delegate = self;
    inputVC.dataBlock = ^(NSString * data){
        self.resultLabel.text = data;
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}


@end
