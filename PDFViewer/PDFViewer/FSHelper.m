//
//  FSHelper.m
//  PDFViewer
//
//  Created by Michael on 12/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "FSHelper.h"

@implementation FSHelper
+ (instancetype)sharedObject{
    static FSHelper *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[self alloc] init];
    });
    return sharedHelper;
}
-(NSString *) contractsDirectory {
    
    NSURL * contractsURL = [[NSURL fileURLWithPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,   NSUserDomainMask, YES)[0]] URLByAppendingPathComponent:@"contracts"];
    
    NSString * contractsPath = [NSString stringWithFormat:@"%@", contractsURL.path];
    NSLog(@"%@",contractsURL.path);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:contractsPath]) {
        
        NSError * error;
        [[NSFileManager defaultManager] createDirectoryAtPath:contractsPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(error) {
            NSLog(@"Creating dir error %@",error);
        }
    }
    return contractsPath;
}
@end
