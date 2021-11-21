//
//  RNTChartManager.m
//  BusinessIntelligence
//
//  Created by McKay Michaelis on 11/18/21.
//

#import <Foundation/Foundation.h>
#import "RNTChartManager.h"
#import <BusinessIntelligence-Swift.h>

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
  set1 = [[LineChartDataSet alloc] initWithEntries:values label:@"Revenue in $"];
  
  set1.drawIconsEnabled = NO;
  
  set1.lineWidth = 1.0;
  set1.circleRadius = 3.0;
  set1.drawCircleHoleEnabled = NO;
  set1.valueFont = [UIFont systemFontOfSize:9.f];
  set1.drawValuesEnabled = NO;
  set1.formLineWidth = 1.0;
  set1.formSize = 15.0;
  
  NSMutableArray *dataSets = [[NSMutableArray alloc] init];
  [dataSets addObject:set1];
  
  LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
  
  view.data = data;
}

- (UIView *)view
{
  LineChartView *chart = [LineChartView new];
  [self setUpChart:chart];
  return chart;
}

- (void)setUpChart:(LineChartView*)view
{
  [view setScaleEnabled:YES];
  view.drawGridBackgroundEnabled = NO;
  ChartXAxis *xAxis = view.xAxis;
  xAxis.labelFont = [UIFont systemFontOfSize:11.f];
  xAxis.labelTextColor = UIColor.blackColor;
  xAxis.valueFormatter = self;
  xAxis.granularity = 1.0;
  xAxis.labelPosition = XAxisLabelPositionBottom;
  ChartYAxis *leftAxis = view.leftAxis;
  leftAxis.enabled = YES;
  LargeValueFormatter *formatter = [LargeValueFormatter new];
  leftAxis.valueFormatter = formatter;
  view.rightAxis.enabled = NO;
  
  view.legend.form = ChartLegendFormLine;
   
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
