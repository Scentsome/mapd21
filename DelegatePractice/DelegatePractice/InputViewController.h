//
//  InputViewController.h
//  DelegatePractice
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol InputViewControllerDelegate
//-(void) inputDidEnterText:(NSString *) inputString;
//@end


@interface InputViewController : UIViewController

//@property id<InputViewControllerDelegate> delegate;
@property void (^ dataBlock) (NSString *) ;
@end
