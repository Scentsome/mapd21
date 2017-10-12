//
//  FSHelper.h
//  PDFViewer
//
//  Created by Michael on 12/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSHelper : NSObject
-(NSString *) contractsDirectory;

+ (instancetype)sharedObject;
@end
