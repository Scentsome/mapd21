//
//  ViewController.h
//  FetchModeDemo
//
//  Created by Michael on 13/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(void) performFetchHandler:(void (^)(UIBackgroundFetchResult)) completionHandler;
@end

