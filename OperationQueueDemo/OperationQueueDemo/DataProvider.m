//
//  DataProvider.m
//  OperationQueueDemo
//
//  Created by Michael on 17/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "DataProvider.h"

@implementation DataProvider
+ (instancetype) sharedInstance
{
    static DataProvider *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataProvider alloc] init];
        instance.names  = [@[] mutableCopy ] ;
        for (NSInteger i = 0 ; i < 40 ; i++){
            [instance.names addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
        
        instance.photos = [@[] mutableCopy ];
        [instance.photos addObject:@"https://c1.staticflickr.com/7/6050/6331306467_559f204017_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/4/3099/2440395110_977e4e82be_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2899/14415030312_16ca51b3fb_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2939/14415179182_f3e0a46f6c_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/7/6235/6331312011_7722a2d6d8_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2648/3956406515_aa4fbf2055_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5153/14229687360_8d056310e0_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/4/3862/14412862241_8fda652d2d_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5543/11630909485_d467890406_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5132/5502830975_316756f5d4_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/7/6050/6331306467_559f204017_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/4/3099/2440395110_977e4e82be_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2899/14415030312_16ca51b3fb_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2939/14415179182_f3e0a46f6c_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/7/6235/6331312011_7722a2d6d8_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2648/3956406515_aa4fbf2055_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5153/14229687360_8d056310e0_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/4/3862/14412862241_8fda652d2d_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5543/11630909485_d467890406_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5132/5502830975_316756f5d4_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/7/6050/6331306467_559f204017_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/4/3099/2440395110_977e4e82be_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2899/14415030312_16ca51b3fb_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2939/14415179182_f3e0a46f6c_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/7/6235/6331312011_7722a2d6d8_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2648/3956406515_aa4fbf2055_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5153/14229687360_8d056310e0_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/4/3862/14412862241_8fda652d2d_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5543/11630909485_d467890406_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5132/5502830975_316756f5d4_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/7/6050/6331306467_559f204017_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/4/3099/2440395110_977e4e82be_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2899/14415030312_16ca51b3fb_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2939/14415179182_f3e0a46f6c_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/7/6235/6331312011_7722a2d6d8_b.jpg"];
        [instance.photos addObject:@"https://c1.staticflickr.com/3/2648/3956406515_aa4fbf2055_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5153/14229687360_8d056310e0_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/4/3862/14412862241_8fda652d2d_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5543/11630909485_d467890406_b.jpg"];
        [instance.photos addObject:@"https://c2.staticflickr.com/6/5132/5502830975_316756f5d4_b.jpg"];
        
        
    });
    return instance;
}
@end
