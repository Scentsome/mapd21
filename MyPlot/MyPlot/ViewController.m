//
//  ViewController.m
//  MyPlot
//
//  Created by Michael on 16/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
@import Charts;

@interface ViewController ()<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet PieChartView *pieChartView;

@end

@implementation ViewController{
    NSString * name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pieChartView.noDataText = @"請加入資料";
    name = @"Michael";
    self.pieChartView.delegate = self;
    [self prepareData];
}

- (void) prepareData {
    NSDictionary * pieChartRawData = @{@"iOS 11":@40, @"iOS 10":@46, @"iOS 9":@9, @"Earlier":@5};
    
    NSMutableArray * yValues = [NSMutableArray array];
    
//    [pieChartRawData enumerateKeysAndObjectsUsingBlock:^(NSString *   key, NSNumber *   obj, BOOL *  stop) {
//        PieChartDataEntry * entry = [[PieChartDataEntry alloc] initWithValue:[obj doubleValue] label:key ];
//        [yValues addObject:entry];
//    }];
    
    for( NSString * key in pieChartRawData.allKeys ){
        NSNumber * obj = pieChartRawData[key];
        PieChartDataEntry * entry = [[PieChartDataEntry alloc] initWithValue:[obj doubleValue] label:key ];
        [yValues addObject:entry];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yValues label:@"iOS Distribution"];
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:[ChartColorTemplates joyful]];
    dataSet.colors = colors;
    
    
    PieChartData *pieChartData = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @"%";
    
    [pieChartData setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];

    self.pieChartView.data = pieChartData;
    [pieChartData setValueTextColor:[UIColor blueColor]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    NSLog(@"Did select %@",entry);
}
-(void)chartValueNothingSelected:(ChartViewBase *)chartView{
    NSLog(@"Nothing selected");
}
- (IBAction)highlight:(id)sender {
    [self.pieChartView highlightValueWithX:2 y:0 dataSetIndex:0];
//    [self.];
//    [UIView animateWithDuration:1.0 animations:^{
        [self.pieChartView setRotationAngle:45];
//    }];
    
}

@end
