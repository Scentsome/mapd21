//
//  StoryCellViewController.m
//  OperationQueueDemo
//
//  Created by Michael on 17/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "StoryCellViewController.h"
#import "DataProvider.h"
@interface StoryCellViewController ()<UITableViewDataSource>

@end

@implementation StoryCellViewController
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [DataProvider sharedInstance].names.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [DataProvider sharedInstance].names[indexPath.row];

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
