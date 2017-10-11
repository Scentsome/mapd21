//
//  MyLabel.m
//  IIIDemoLong
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel

-(void) awakeFromNib{
    [super awakeFromNib];
    
    self.layer.borderColor = UIColor.blueColor.CGColor;
    
    self.layer.borderWidth = 1.0;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
