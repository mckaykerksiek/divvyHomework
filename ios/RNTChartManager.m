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

RCT_CUSTOM_VIEW_PROPERTY(yValues, [double], LineChartView) {
  
  NSMutableArray *values = [[NSMutableArray alloc] init];
   
   for (int i = 0; i < [json count]; i++)
   {
     double val = [RCTConvert CGFloat:json[i]];
      [values addObject:[[ChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
   }
  LineChartDataSet *set1 = nil;
  set1 = [[LineChartDataSet alloc] initWithEntries:values label:@"Monthly Revenue"];
  
  set1.drawIconsEnabled = NO;
  
  set1.lineDashLengths = @[@5.f, @2.5f];
  set1.highlightLineDashLengths = @[@5.f, @2.5f];
  [set1 setColor:UIColor.blackColor];
  [set1 setCircleColor:UIColor.blackColor];
  set1.lineWidth = 1.0;
  set1.circleRadius = 3.0;
  set1.drawCircleHoleEnabled = NO;
  set1.valueFont = [UIFont systemFontOfSize:9.f];
//         set1.formLineDashLengths = @[@5.f, @2.5f];
  set1.formLineWidth = 1.0;
  set1.formSize = 15.0;
  
  NSMutableArray *dataSets = [[NSMutableArray alloc] init];
  [dataSets addObject:set1];
  
  LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
  
  view.data = data;
}

RCT_CUSTOM_VIEW_PROPERTY(xValues, [String], LineChartView) {
  
}



- (UIView *)view
{
//  RNTMapView *map = [RNTMapView new];
//    map.delegate = self;
//    return map;
  LineChartView *chart = [LineChartView new];
  return chart; //[self setDataCount:6 range:20];
}

- (LineChartData *)dataWithCount:(int)count range:(double)range
{
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = (double) (arc4random_uniform(range)) + 3;
        [yVals addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithEntries:yVals label:@"DataSet 1"];
    
    set1.lineWidth = 1.75;
    set1.circleRadius = 5.0;
    set1.circleHoleRadius = 2.5f;
    [set1 setColor:UIColor.whiteColor];
    [set1 setCircleColor:UIColor.whiteColor];
    set1.highlightColor = UIColor.whiteColor;
    set1.drawValuesEnabled = NO;
    
    return [[LineChartData alloc] initWithDataSet:set1];
}

- (LineChartView *)setDataCount:(int)count range:(double)range
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
    LineChartView *chartView = [LineChartView new];
  
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:YES];
    chartView.pinchZoomEnabled = YES;
    chartView.drawGridBackgroundEnabled = NO;

//    // x-axis limit line
//    ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:10.0 label:@"Index 10"];
//    llXAxis.lineWidth = 4.0;
//    llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
//    llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
    
    //[_chartView.xAxis addLimitLine:llXAxis];
    
    chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
    chartView.xAxis.gridLineDashPhase = 0.f;
//
//    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:150.0 label:@"Upper Limit"];
//    ll1.lineWidth = 4.0;
//    ll1.lineDashLengths = @[@5.f, @5.f];
//    ll1.valueFont = [UIFont systemFontOfSize:10.0];
//
//    ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30.0 label:@"Lower Limit"];
//    ll2.lineWidth = 4.0;
//    ll2.lineDashLengths = @[@5.f, @5.f];
//    ll2.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartYAxis *leftAxis = chartView.leftAxis;
    [leftAxis removeAllLimitLines];
//    [leftAxis addLimitLine:ll1];
//    [leftAxis addLimitLine:ll2];
//    leftAxis.axisMaximum = 200.0;
//    leftAxis.axisMinimum = -50.0;
//    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
    chartView.rightAxis.enabled = NO;
    
    chartView.legend.form = ChartLegendFormLine;
  
    NSMutableArray *values = [[NSMutableArray alloc] init];
     
     for (int i = 0; i < count; i++)
     {
         double val = 77793740.07 + i * 10;
         [values addObject:[[ChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
     }
     
     LineChartDataSet *set1 = nil;
     if (chartView.data.dataSetCount > 0)
     {
         set1 = (LineChartDataSet *)chartView.data.dataSets[0];
         [set1 replaceEntries: values];
         [chartView.data notifyDataChanged];
         [chartView notifyDataSetChanged];
     }
     else
     {
         set1 = [[LineChartDataSet alloc] initWithEntries:values label:@"Monthly Revenue"];
         
         set1.drawIconsEnabled = NO;
         
         set1.lineDashLengths = @[@5.f, @2.5f];
         set1.highlightLineDashLengths = @[@5.f, @2.5f];
         [set1 setColor:UIColor.blackColor];
         [set1 setCircleColor:UIColor.blackColor];
         set1.lineWidth = 1.0;
         set1.circleRadius = 3.0;
         set1.drawCircleHoleEnabled = NO;
         set1.valueFont = [UIFont systemFontOfSize:9.f];
//         set1.formLineDashLengths = @[@5.f, @2.5f];
         set1.formLineWidth = 1.0;
         set1.formSize = 15.0;
         
//         NSArray *gradientColors = @[
//                                     (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
//                                     (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
//                                     ];
//         CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
//
//         set1.fillAlpha = 1.f;
//         set1.drawFilledEnabled = YES;
//
//         CGGradientRelease(gradient);
         
         NSMutableArray *dataSets = [[NSMutableArray alloc] init];
         [dataSets addObject:set1];
         
         LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
         
         chartView.data = data;
     }
  
    return chartView;
}


@end
