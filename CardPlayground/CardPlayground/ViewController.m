//
//  ViewController.m
//  CardPlayground
//
//  Created by Michael on 16/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
#import "CardView.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *cards;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for(NSInteger idx = 0 ; idx < self.cards.count ; idx++){
        
        NSString * imageName = [NSString stringWithFormat:@"front%ld",(long)idx];
        
        CardView * card = self.cards[idx];
        card.frontImage = [UIImage imageNamed:imageName];
  
    }
    [self.cards makeObjectsPerformSelector:@selector(setBackImage:) withObject:[UIImage imageNamed:@"back"] ];
    [self.cards makeObjectsPerformSelector:@selector(showFront)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)exchangeImage:(id)sender {
    [self.cards makeObjectsPerformSelector:@selector(changeImage)];
}


@end
