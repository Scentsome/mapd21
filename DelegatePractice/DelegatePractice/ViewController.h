//
//  ViewController.h
//  DelegatePractice
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property int day;

@property int  (^myBlock) (int,int);

-(void) funcInt:(int) day;
-(void) funcBlock:(int  (^) (int,int)) myBlock;
@end

