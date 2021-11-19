//
//  RNTChartManager.m
//  BusinessIntelligence
//
//  Created by McKay Michaelis on 11/18/21.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

#import <React/RCTViewManager.h>
@import Charts;



@interface RNTChartManager : RCTViewManager
@end

@implementation RNTChartManager

RCT_EXPORT_MODULE(RNTChart)



- (UIView *)view
{
//  RNTMapView *map = [RNTMapView new];
//    map.delegate = self;
//    return map;
  BarChartView *chart = [BarChartView new];
  return [self setDataCount:6 range:20];
}

- (BarChartView *)setDataCount:(int)count range:(double)range
{
//    {
//        "seq": 0,
//        "date": "2019-03-12 00:14:10",
//        "value": 77793740.07
//    },
//    {
//        "seq": 1,
//        "date": "2019-02-12 00:14:10",
//        "value": 17659305.4
//    }
    BarChartView *chartView = [BarChartView new];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
//        double mult = (range + 1);
//        double val = (double) (arc4random_uniform(mult)) + mult / 3.0;
      double val = (double) 77793740.07;
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
    }
    
    BarChartDataSet *set1 = nil;
    if (chartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)chartView.data.dataSets[0];
        [set1 replaceEntries:yVals];
        [chartView.data notifyDataChanged];
        [chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@"DataSet"];
        set1.colors = ChartColorTemplates.vordiplom;
        set1.drawValuesEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        
        chartView.data = data;
        chartView.fitBars = YES;
    }
    
    [chartView setNeedsDisplay];
    return chartView;
}


@end
