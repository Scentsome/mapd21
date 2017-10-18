//
//  SimpleGCDViewController.m
//  OperationQueueDemo
//
//  Created by Michael on 17/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "SimpleGCDViewController.h"
#import "DataProvider.h"
@interface SimpleGCDViewController ()<UITableViewDataSource>

@end

@implementation SimpleGCDViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [DataProvider sharedInstance].names.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    cell.textLabel.text = @"Default";
    cell.imageView.image = [UIImage imageNamed:@"loading"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[DataProvider sharedInstance].photos[indexPath.row]]];
        UIImage * image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UITableViewCell * currentCell = [tableView cellForRowAtIndexPath:indexPath];
            currentCell.imageView.image = image;
            
            currentCell.textLabel.text = [DataProvider sharedInstance].names[indexPath.row] ;
                       });
        
        
    });
    

    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
