//
//  BarChartViewController.m
//  MyPlot
//
//  Created by Michael on 16/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "BarChartViewController.h"
@import Charts;
@interface BarChartViewController ()
@property (weak, nonatomic) IBOutlet BarChartView *barChartView;

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBarData];
}
-(void) setupBarData {
    NSArray * values = @[@20.0, @4.0, @6.0, @3.0, @12.0, @16.0, @4.0, @18.0, @2.0, @4.0, @5.0, @4.0];
    NSMutableArray * dataEntries = [NSMutableArray array];
    [values enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        BarChartDataEntry * dataEntry = [[BarChartDataEntry alloc] initWithX:idx y:obj.doubleValue ];
        [dataEntries addObject:dataEntry];
    }];
    BarChartDataSet * dataSet = [[BarChartDataSet alloc] initWithValues:dataEntries label:@"Units Sold"];
    dataSet.colors = @[[UIColor blueColor]];
    BarChartData * barChartData = [[BarChartData alloc] initWithDataSets:@[dataSet]];
    self.barChartView.data = barChartData;
     self.barChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    ChartLimitLine * limitLine = [[ChartLimitLine alloc] initWithLimit:11 label:@"Target"];
    
    [self.barChartView.rightAxis addLimitLine:limitLine];
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
