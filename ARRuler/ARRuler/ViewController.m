//
//  ViewController.m
//  ARRuler
//
//  Created by Michael on 12/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
#import "ARRuler-Swift.h"

@import ARKit;
//#import <ARKit/ARKit.h>
@import SceneKit;




SCNVector3 postionFromMatrix(matrix_float4x4 matrix){
    simd_float4 column = matrix.columns[3];
    return SCNVector3Make(column.x, column.y, column.z);
}

CGFloat distanceToDestination(SCNVector3 origin, SCNVector3 dest){
    CGFloat dx = dest.x - origin.x;
    CGFloat dy = dest.y - origin.y;
    CGFloat dz = dest.z - origin.z;
    return sqrt(dx*dx + dy*dy + dz*dz);
}



@interface ViewController ()<ARSCNViewDelegate>
@property ARSCNView * sceneView;
@property UILabel * msgLabel;
@end

@implementation ViewController{
    NSMutableArray * nodes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    nodes = [@[] mutableCopy];
    self.sceneView = [[ARSCNView alloc] initWithFrame:CGRectZero];
    self.sceneView.delegate = self;
    
    [self.view addSubview:self.sceneView];
    
    self.msgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.msgLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1] ;
    self.msgLabel.textAlignment = NSTextAlignmentCenter ;
    self.msgLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.msgLabel];
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.sceneView addGestureRecognizer:tapRecognizer];
}

-(void) handleTap:(UITapGestureRecognizer *) sender {
    CGPoint tapLocation = [sender locationInView:self.sceneView];
    NSArray * hitTestResults = [self.sceneView hitTest:tapLocation types:ARHitTestResultTypeFeaturePoint];
    if ([hitTestResults firstObject] != nil) {
        
        ARHitTestResult * result = [hitTestResults firstObject];
        SCNVector3 position = postionFromMatrix(result.worldTransform);
        SphereNode * sphere = [[SphereNode alloc] initWithPosition:position];
        [self.sceneView.scene.rootNode addChildNode:sphere];
        SphereNode * lastNode = [nodes lastObject];
        [nodes addObject:sphere];
        if (lastNode != nil){
            CGFloat distance = distanceToDestination(lastNode.position, sphere.position);
            self.msgLabel.text = [NSString stringWithFormat:@"Distance: %.2f meters",distance];
        }
    }
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.sceneView.frame = self.view.bounds;
    self.msgLabel.frame = CGRectMake(0, 16, self.view.bounds.size.width, 64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ARWorldTrackingConfiguration * config = [ARWorldTrackingConfiguration new];
    [self.sceneView.session runWithConfiguration:config options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];
    
}
-(void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera{
    NSString * status = @"Loading...";
    switch (camera.trackingState) {
        case ARTrackingStateNotAvailable:{
            status = @"Not Available";
            break;
        }
        case ARTrackingStateLimited:{
            status = @"Analyzing";
            break;
        }
        case ARTrackingStateNormal:{
            status = @"Ready";
            break;
        }
        default:
            status = @"Unknown";
            break;
    }
    self.msgLabel.text = status;
}

@end
