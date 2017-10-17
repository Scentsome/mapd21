//
//  CardView.h
//  CardPlayground
//
//  Created by Michael on 16/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIImageView
@property UIImage * frontImage;
@property UIImage * backImage;

-(void) showFront;
-(void) showBack;
-(void) lock;
-(void) unlock;
-(void) changeImage;
@end
