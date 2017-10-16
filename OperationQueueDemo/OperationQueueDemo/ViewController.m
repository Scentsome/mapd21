//
//  ViewController.m
//  OperationQueueDemo
//
//  Created by Michael on 13/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray * numbers;
@property NSMutableArray * jobQueue;
@property NSMutableArray * photos;
@property NSOperationQueue * operationQueue;
@end

@implementation ViewController
- (IBAction)check:(id)sender {
    NSLog(@"count %@",self.jobQueue);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = [@[] mutableCopy ];
    [self.photos addObject:@"https://c1.staticflickr.com/7/6050/6331306467_559f204017_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/4/3099/2440395110_977e4e82be_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2899/14415030312_16ca51b3fb_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2939/14415179182_f3e0a46f6c_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/7/6235/6331312011_7722a2d6d8_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2648/3956406515_aa4fbf2055_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5153/14229687360_8d056310e0_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/4/3862/14412862241_8fda652d2d_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5543/11630909485_d467890406_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5132/5502830975_316756f5d4_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/7/6050/6331306467_559f204017_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/4/3099/2440395110_977e4e82be_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2899/14415030312_16ca51b3fb_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2939/14415179182_f3e0a46f6c_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/7/6235/6331312011_7722a2d6d8_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2648/3956406515_aa4fbf2055_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5153/14229687360_8d056310e0_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/4/3862/14412862241_8fda652d2d_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5543/11630909485_d467890406_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5132/5502830975_316756f5d4_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/7/6050/6331306467_559f204017_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/4/3099/2440395110_977e4e82be_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2899/14415030312_16ca51b3fb_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2939/14415179182_f3e0a46f6c_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/7/6235/6331312011_7722a2d6d8_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2648/3956406515_aa4fbf2055_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5153/14229687360_8d056310e0_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/4/3862/14412862241_8fda652d2d_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5543/11630909485_d467890406_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5132/5502830975_316756f5d4_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/7/6050/6331306467_559f204017_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/4/3099/2440395110_977e4e82be_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2899/14415030312_16ca51b3fb_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2939/14415179182_f3e0a46f6c_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/7/6235/6331312011_7722a2d6d8_b.jpg"];
    [self.photos addObject:@"https://c1.staticflickr.com/3/2648/3956406515_aa4fbf2055_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5153/14229687360_8d056310e0_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/4/3862/14412862241_8fda652d2d_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5543/11630909485_d467890406_b.jpg"];
    [self.photos addObject:@"https://c2.staticflickr.com/6/5132/5502830975_316756f5d4_b.jpg"];
    
    self.operationQueue = [NSOperationQueue new];
    self.jobQueue = [[NSMutableArray alloc ] initWithCapacity:40];
    self.numbers = [@[] mutableCopy ] ;
    for (NSInteger i = 0 ; i < 40 ; i++){
        [self.numbers addObject:@(i)];
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QueueCell"];
    cell.textLabel.text = @"Default";
    cell.imageView.image = [UIImage imageNamed:@"loading"];
    
    NSBlockOperation * blockOperation = [NSBlockOperation blockOperationWithBlock:^{
    }];
    
//    NSBlockOperation * blockOperation = [[NSBlockOperation alloc] init];

//    __weak NSBlockOperation * weakBlock = blockOperation;
    
    [blockOperation addExecutionBlock:^{
//        if ([weakBlock isCancelled]) {
//            NSLog(@"cancel block... in cell");
//            return ;
//        }
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.photos[indexPath.row]]];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",self.numbers[indexPath.row]] ;
            UIImage * image = [UIImage imageWithData:data];
            cell.imageView.image = image;
        }];
    }];
    
    self.jobQueue[indexPath.row] = blockOperation;
    
    [self.operationQueue addOperation:blockOperation];
//    [blockOperation start];
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSOperation * operation = self.jobQueue[indexPath.row];
    [operation cancel];
    self.jobQueue[indexPath.row] = @"";
//    NSLog(@"cancel cell");
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numbers.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0;
}

@end
