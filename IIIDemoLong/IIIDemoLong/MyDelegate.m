//
//  MyDelegate.m
//  IIIDemoLong
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "MyDelegate.h"

@implementation MyDelegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"App Launched");
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    self.window.backgroundColor = UIColor.blueColor;
    
    [self.window makeKeyAndVisible];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * vc = [storyboard instantiateInitialViewController];
    
    self.window.rootViewController = vc;
    return YES;
}
-(void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"enter back ground");
}


@end
