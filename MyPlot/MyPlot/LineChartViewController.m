//
//  LineChartViewController.m
//  MyPlot
//
//  Created by Michael on 16/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//
@import Charts;
#import "LineChartViewController.h"

@interface LineChartViewController ()<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;

@end

@implementation LineChartViewController

-(void) setupLineData{
    NSArray * values = @[@20.0, @4.0, @6.0, @3.0, @12.0, @16.0, @4.0, @18.0, @2.0, @4.0, @5.0, @4.0];
    NSMutableArray * dataEntries = [NSMutableArray array];
    [values enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        ChartDataEntry * dataEntry = [[ChartDataEntry alloc] initWithX:idx y:obj.floatValue];
        [dataEntries addObject:dataEntry];
    }];
    LineChartDataSet * dataSet = [[LineChartDataSet alloc] initWithValues:dataEntries label:@"Units Sold"];
    [dataSet setCircleColor:[UIColor blueColor]];
    dataSet.colors = @[[UIColor blueColor]];
    LineChartData * chartData = [[LineChartData alloc] initWithDataSet:dataSet];
    self.lineChartView.data = chartData;
    self.lineChartView.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLineData];
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
-(void)chartValueNothingSelected:(ChartViewBase *)chartView{
    
}

-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    NSLog(@"%@",entry);
}

@end
