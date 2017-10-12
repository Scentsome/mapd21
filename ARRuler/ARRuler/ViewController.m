//
//  ViewController.m
//  ARRuler
//
//  Created by Michael on 12/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
@import ARKit;
//#import <ARKit/ARKit.h>
@import SceneKit;


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
