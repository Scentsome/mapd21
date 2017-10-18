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

-(CGFloat) random{
    CGFloat randomFloat =((float)arc4random())/0xFFFFFFFF;
    return randomFloat;
}


-(CGFloat) random:(CGFloat)theMin toMax:(CGFloat)theMax{
    
    return [self random]* (theMax - theMin) + theMin;
}

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [SKColor whiteColor];
    
    self.player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
    
    self.player.position = CGPointMake(0-self.size.width/2+50, 0);
    [self addChild:self.player];
    
    [self addMonster];
}
//  GameScene.m
-(void) addMonster{
    // Create sprite
    SKSpriteNode * monster = [[SKSpriteNode alloc] initWithImageNamed:@"monster"];
    
    // Determine where to spawn the monster along the Y axis
    CGFloat actualY = [self random:-self.size.height/2+monster.size.height/2 toMax:(self.size.height/2-monster.size.height/2)];
    
//    actualY = 0;
    // Position the monster slightly off-screen along the right edge
    // and along a random position along the Y axis as calculated above
    monster.position = CGPointMake(self.size.width/2 + monster.size.width/2, actualY);
    
    // Add the monster to the scene
    [self addChild:monster];
    
    CGPoint moveTo = CGPointMake(-self.size.width-(monster.size.width/2), actualY);
    
    // Determine speed of the monster
    CGFloat actualDuration = [self random:(CGFloat)2.0 toMax:(CGFloat)4.0];
    
    SKAction * actionMove = [SKAction moveTo:moveTo duration:(NSTimeInterval) actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    
    [monster runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}




-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
