//
//  GameViewController.m
//  SceneDemo
//
//  Created by Michael on 11/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController()<SCNSceneRendererDelegate>
@property SCNView * scnView;
@property SCNScene * scnScene;
@property SCNNode * cameraNode;
@end
@implementation GameViewController{
    NSTimeInterval spawnTime  ;
}
//NSTimeInterval spawnTime  = 8;



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self setupScene];
    [self setupCamera];
    [self spawnShape];
     spawnTime = 0.5;

}
-(void) setupView{
    self.scnView = (SCNView *)self.view;
    self.scnView.delegate = self;

}

- (void) setupCamera {
    self.cameraNode = [SCNNode new];
    self.cameraNode.camera = [SCNCamera new];
    self.cameraNode.position = SCNVector3Make(0.0, 0.0, 10.0);
    [self.scnScene.rootNode addChildNode:self.cameraNode];
}

-(void) setupScene{
    self.scnScene = [SCNScene new];
    self.scnView.scene = self.scnScene;
    self.scnScene.background.contents = [UIImage imageNamed:@"Background_Diffuse"];
    
}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void) spawnShape {
    
    SCNGeometry * geometry = [SCNGeometry geometry];
    
    switch (arc4random_uniform(8)) {
        case 0:
            geometry = [SCNSphere sphereWithRadius:0.5];
            break;
        case 1:
            geometry = [SCNBox boxWithWidth:1.0 height:1.0 length:1.0 chamferRadius:0];
            break;
        case 2:
            geometry = [SCNPyramid pyramidWithWidth:1.0 height:1.0 length:1.0];
            break;
        case 3:
            geometry = [SCNTorus torusWithRingRadius:0.5 pipeRadius:0.25];
            break;
        case 4:
            geometry = [SCNCapsule capsuleWithCapRadius:0.3 height:2.5];
            break;
        case 5:
            geometry = [SCNCylinder cylinderWithRadius:0.3 height:2.5];
            break;
        case 6:
            geometry = [SCNCone coneWithTopRadius:0.25 bottomRadius:0.5 height:1.0];
            break;
        case 7:
            geometry = [SCNTube tubeWithInnerRadius:0.25 outerRadius:0.5 height:1.0];
            break;
        default:
            break;
    }
    SCNNode *geometerNode = [SCNNode nodeWithGeometry:geometry];
    
    
    geometerNode.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:nil];
    NSInteger X = (NSInteger)(arc4random_uniform(5)) - 2;
    NSInteger Y = 10 + arc4random() % (18 - 10 + 1);
    SCNVector3 force = SCNVector3Make(8, 0, 0);
    SCNVector3 position = SCNVector3Make(0.05, 0.05, 0.05);
    [geometerNode.physicsBody applyForce:force atPosition:position impulse:true];
    
    UIColor *color = [UIColor colorWithRed: arc4random_uniform(256)/255.0
                                     green: arc4random_uniform(256)/255.0
                                      blue: arc4random_uniform(256)/255.0
                                     alpha: 1.0];
    geometry.materials.firstObject.diffuse.contents = color;
    [self.scnScene.rootNode addChildNode:geometerNode];
}

- (void)renderer:(id<SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time{
    if (time > spawnTime) {
        
        [self spawnShape];
        spawnTime = time + 0.5;
    }

//    [self spawnShape];
}
@end
