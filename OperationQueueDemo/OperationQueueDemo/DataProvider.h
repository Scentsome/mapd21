//
//  DataProvider.h
//  OperationQueueDemo
//
//  Created by Michael on 17/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataProvider : NSObject
@property NSMutableArray * names;
@property NSMutableArray * photos;
+ (instancetype) sharedInstance;
@end
