//
//  GameScene.m
//  GameIntro
//
//  Created by Michael on 18/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"
#import <AVFoundation/AVFoundation.h>


#define none            0
#define allObject       UINT32_MAX
#define theMonster      0b1
#define theProjectile   0b10
@interface GameScene()<SKPhysicsContactDelegate, AVAudioPlayerDelegate>
@property (nonatomic) SKSpriteNode * player;
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;

@end

@implementation GameScene{
    NSInteger monsterDestoryed;
}


-(void) playBackgroundMusic:(NSString *) theFilename{
    NSURL * url = [[NSBundle mainBundle] URLForResource:theFilename withExtension:nil];
    if (url == nil) {
        NSLog(@"Couldn't find file: %@", theFilename);
        return ;
    }
    NSError * error ;
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (self.backgroundMusicPlayer == nil) {
        NSLog(@"Could not create audio player: %@", error);
        return;
    }
    
    if(error != nil ){
        NSLog(@"%@",error);
    }else {
        self.backgroundMusicPlayer.numberOfLoops = -1;
        [self.backgroundMusicPlayer prepareToPlay];
        [self.backgroundMusicPlayer play];
    }
}


-(CGFloat) random{
    CGFloat randomFloat =((float)arc4random())/0xFFFFFFFF;
    return randomFloat;
}


-(CGFloat) random:(CGFloat)theMin toMax:(CGFloat)theMax{
    
    return [self random]* (theMax - theMin) + theMin;
}

-(CGPoint) addFromLeft:(CGPoint)left andRight:(CGPoint) right{
    return CGPointMake((left.x + right.x), (left.y + right.y));
}

-(CGPoint) minusFromLeft:(CGPoint)left andRight:(CGPoint) right{
    return CGPointMake((left.x - right.x), (left.y - right.y));
}

-(CGPoint) timeFromPoint:(CGPoint)point withScalar:(CGFloat) scalar{
    return CGPointMake((point.x * scalar), (point.y *scalar));
}

-(CGPoint) divideFromPoint:(CGPoint)point withScalar:(CGFloat) scalar{
    return CGPointMake((point.x / scalar), (point.y / scalar));
}

-(CGFloat) sqrt:(CGFloat) a{
    return (CGFloat) sqrtf((float) a);
}

-(CGFloat) length:(CGPoint) point{
    return sqrt(point.x * point.x + point.y * point.y);
}

-(CGPoint) normalized:(CGPoint) point{
    CGFloat pointLength = [self length:point];
    CGPoint newPoint = CGPointMake(point.x/pointLength, point.y/pointLength);
    return newPoint;
}

- (void)didMoveToView:(SKView *)view {
    
    monsterDestoryed = 0;
//    [self playBackgroundMusic:@"background-music-aac.caf"];

    
    self.backgroundMusicPlayer.delegate = self;
    self.backgroundColor = [SKColor whiteColor];
    
    self.player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
//    self.player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, 10)];
    self.player.position = CGPointMake(0-self.size.width/2+50, 0);
    [self addChild:self.player];
    
//    [self addMonster];
    __weak GameScene * weakSelf = self;

    [self.player runAction:[SKAction repeatActionForever:[SKAction sequence:@[ [SKAction runBlock:^{
        [weakSelf addMonster];
    }],[SKAction waitForDuration:1.0]]]]];
    
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;

}
//  GameScene.m
-(void) addMonster{
    // Create sprite
    SKSpriteNode * monster = [[SKSpriteNode alloc] initWithImageNamed:@"monster"];
    // physic body
    
    
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: monster.size];
    monster.physicsBody.dynamic = YES;
    monster.physicsBody.categoryBitMask = theMonster;
    monster.physicsBody.contactTestBitMask = theProjectile;
    monster.physicsBody.collisionBitMask = none;
    
    
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
    
//    [monster runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    __weak GameScene * weakSelf = self;
    SKAction * loseAction = [SKAction runBlock:^{
        [weakSelf.backgroundMusicPlayer stop];
        weakSelf.backgroundMusicPlayer = nil;
//        self.backgroundMusicPlayer = nil;
        
        SKTransition * reveal = [SKTransition flipHorizontalWithDuration:0.5];
        
        GameOverScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size win:false];
        [weakSelf.view presentScene:gameOverScene transition:reveal];
        
        
    }];
    
    [monster runAction:[SKAction sequence:@[actionMove, loseAction, actionMoveDone]]];

}


-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self runAction:[SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:false]];

    UITouch * touch = (UITouch*)[touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    SKSpriteNode * projectile = [[SKSpriteNode alloc] initWithImageNamed:@"projectile"];
    projectile.position = self.player.position;
    
    
    projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile.size.width/2];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.categoryBitMask = theProjectile;
    projectile.physicsBody.contactTestBitMask = theMonster;
    projectile.physicsBody.collisionBitMask = none;
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    
    CGPoint offset = CGPointMake(touchLocation.x - projectile.position.x, touchLocation.y - projectile.position.y);
    
    if (offset.x < 0) {
        return ;
    }
    
    [self addChild:projectile];
    
    CGPoint direction = [self normalized:offset];
    CGPoint shootAmount = CGPointMake(direction.x * 1000, direction.y *1000);
    CGPoint realDest = CGPointMake(shootAmount.x + projectile.position.x, shootAmount.y + projectile.position.y);
    
    SKAction * actionMove = [SKAction moveTo:realDest duration:1.0];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    
    [projectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
    
    
}

-(void) projectileDidCollideWithMonster:(SKSpriteNode*) projectile toMonster:(SKSpriteNode*) monster{
    
    // remove the projectile and monster from the scene when they
    // collide
    NSLog(@"Hit");
    [projectile removeFromParent];
    [monster removeFromParent];
}
// GameScene.m
// contact delegate method
-(void) didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody * firstBody;
    SKPhysicsBody * secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (((firstBody.categoryBitMask & theMonster) != 0) && ((secondBody.categoryBitMask & theProjectile) != 0)) {
        [self projectileDidCollideWithMonster:(SKSpriteNode *) firstBody.node toMonster:(SKSpriteNode*) secondBody.node];
    }
    
    monsterDestoryed++;
    
    if (monsterDestoryed > 3) { // kill over 30 monster get win
        [self.backgroundMusicPlayer stop];
        self.backgroundMusicPlayer = nil;
        
        SKTransition * reveal = [SKTransition flipHorizontalWithDuration:0.5];
        GameOverScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size win:true];
        [self.view presentScene:gameOverScene transition:reveal];
    }

    
    
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if(flag) {
        
    }
    
    
}

-(void)update:(CFTimeInterval)currentTime {
//    NSLog(@"%d",currentTime);
}
-(void) dealloc {
    NSLog(@"....destroy game scene");
}
@end
