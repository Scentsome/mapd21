//
//  ViewController.m
//  OperationQueueDemo
//
//  Created by Michael on 13/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "GCDQueueViewController.h"
#import "DataProvider.h"
@interface GCDQueueViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray * jobQueue;
@property NSOperationQueue * operationQueue;
@end

@implementation GCDQueueViewController
- (IBAction)check:(id)sender {
    NSLog(@"count %@",self.jobQueue);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.operationQueue = [NSOperationQueue new];
    self.jobQueue = [[NSMutableArray alloc ] initWithCapacity:40];
  
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
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[DataProvider sharedInstance].photos[indexPath.row]]];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = [DataProvider sharedInstance].names[indexPath.row] ;
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
    return [DataProvider sharedInstance].names.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0;
}

@end
