//
//  RNTChartManager.m
//  BusinessIntelligence
//
//  Created by McKay Michaelis on 11/18/21.
//

#import <Foundation/Foundation.h>
#import "RNTChartManager.h"

@import Charts;

@interface RNTChartManager () < IChartAxisValueFormatter>

@end

typedef struct {
    NSNumber* x;
    NSNumber* y;
} XYValues;

XYValues createXYValues(NSNumber* x, NSNumber* y) {
    XYValues vals;
    vals.x = x;
    vals.y = y;
    return vals;
};

@implementation RCTConvert (XYValues)

RCT_CUSTOM_CONVERTER(XYValues, XYValues, createXYValues(json[@"x"], json[@"y"]) )

@end

@implementation RNTChartManager


RCT_EXPORT_MODULE(RNTChart)

RCT_CUSTOM_VIEW_PROPERTY(values, [XYValues], LineChartView) {
  
 
  NSMutableArray *values = [[NSMutableArray alloc] init];
   
   for (int i = 0; i < [json count]; i++)
   {
     XYValues val = [RCTConvert XYValues:json[i]];
      [values addObject:[[ChartDataEntry alloc] initWithX:[val.x doubleValue] y:[val.y doubleValue] icon: [UIImage imageNamed:@"icon"]]];
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
  LineChartView *chart = [LineChartView new];
  [self setUpChart:chart];
  return chart; //[self setDataCount:6 range:20];
}

- (void)setUpChart:(LineChartView*)view
{
  view.dragEnabled = YES;
  [view setScaleEnabled:YES];
  view.pinchZoomEnabled = YES;
  view.drawGridBackgroundEnabled = NO;
  
  ChartXAxis *xAxis = view.xAxis;
  xAxis.labelFont = [UIFont systemFontOfSize:11.f];
  xAxis.labelTextColor = UIColor.blueColor;
  xAxis.axisMinimum = 1.0;
  xAxis.granularity = 1.0;
  xAxis.valueFormatter = self;
  
  //xAxis.label
  ChartYAxis *leftAxis = view.leftAxis;
  leftAxis.enabled = NO;
  
  view.rightAxis.enabled = NO;
  
  view.legend.form = ChartLegendFormLine;
   
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
    
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:11.f];
    xAxis.labelTextColor = UIColor.blueColor;
//    xAxis.drawGridLinesEnabled = NO;
//    xAxis.drawAxisLineEnabled = NO;
    chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
    chartView.xAxis.gridLineDashPhase = 0.f;
    
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


- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
  NSArray<NSString *> *months = @[
                @"Jan", @"Feb", @"Mar",
                @"Apr", @"May", @"Jun",
                @"Jul", @"Aug", @"Sep",
                @"Oct", @"Nov", @"Dec"
                ];
    return months[(int)value % months.count];
}

@end
