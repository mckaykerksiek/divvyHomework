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
  return [[BarChartView.class alloc] init];
}

@end
