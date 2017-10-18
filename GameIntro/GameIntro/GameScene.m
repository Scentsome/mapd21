//
//  GameScene.m
//  GameIntro
//
//  Created by Michael on 18/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()
@property (nonatomic) SKSpriteNode * player;

@end

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [SKColor whiteColor];
    
    self.player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
    
    self.player.position = CGPointMake(0-self.size.width/2+50, 0);
    [self addChild:self.player];
    
}





-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
