//
//  CardPlaygroundTests.m
//  CardPlaygroundTests
//
//  Created by Michael on 16/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CardView.h"
@interface CardPlaygroundTests : XCTestCase

@end

@implementation CardPlaygroundTests{
    CardView * cardView;
}

- (void)setUp {
    [super setUp];
    cardView = [CardView new];
    cardView.frontImage = [UIImage imageNamed:@"front0"];
    cardView.backImage = [UIImage imageNamed:@"back"];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    cardView = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testShowFrontImage {
    [cardView showFront];
    
//    if(cardView.image != cardView.frontImage){
//        NSLog(@"error!!");
//    }
XCTAssertEqualObjects(cardView.image, cardView.frontImage, @"should be the same");
//    XCTAssertEqual(cardView.image, cardView.frontImage, @"should be the same");
}

-(void) testLockAfterShowBack {
    [cardView showFront];
    [cardView lock];
    [cardView showBack];
    XCTAssertEqualObjects(cardView.image, cardView.frontImage , @"should be front");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
-(void) testChangeImage{
    [cardView showFront];
    [cardView changeImage];
    XCTAssertEqualObjects(cardView.image, cardView.backImage , @"should be front");
}

-(void) testChangeImageAfterBack{
    [cardView showBack];
    [cardView changeImage];
    XCTAssertEqualObjects(cardView.image, cardView.frontImage , @"should be front");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
