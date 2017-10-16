//
//  Car.m
//  MyBook
//
//  Created by Michael on 16/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "Car.h"

@implementation Car
-(BOOL)isEqual:(Car *)object{
    if([object.name isEqualToString:self.name] && [object.price isEqual:self.price]){
        return YES;
    }
        
        return NO;
}
@end
