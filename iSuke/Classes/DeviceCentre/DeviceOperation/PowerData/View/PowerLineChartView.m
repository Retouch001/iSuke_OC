//
//  PowerLineChartView.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PowerLineChartView.h"
#import "iSuke-Bridging-Header.h"

@interface PowerLineChartView ()<ChartViewDelegate>

@property (strong, nonatomic)  LineChartView *lineChartView;

@property (nonatomic, strong)UILabel *markY;


@end

@implementation PowerLineChartView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self buildSubView];
    
    [self setData];
}

- (void)buildSubView{
    self.lineChartView = [[LineChartView alloc] init];
    self.lineChartView.backgroundColor = UIColor.whiteColor;
    self.lineChartView.delegate = self;
    
    
    self.lineChartView.noDataText = RTLocalizedString(@"无数据");
    //self.lineChartView.noDataTextColor = kColorThirdText;
    self.lineChartView.noDataFont = [UIFont boldSystemFontOfSize:20];
    
    self.lineChartView.scaleYEnabled = NO;//Y轴缩放
    self.lineChartView.doubleTapToZoomEnabled = NO;//双击缩放
    self.lineChartView.legend.enabled = NO;
    
    
    //设置Y轴类型与样式
    self.lineChartView.rightAxis.enabled = NO;
    ChartYAxis *yAxis = _lineChartView.leftAxis;
    yAxis.enabled = YES;
    yAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
    yAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    yAxis.labelTextColor = [UIColor colorWithHexString:@"0x9c9c9c"];//文字颜色
    yAxis.gridColor = kColorTableViewSeparatorLine;//网格线颜色
    
    
    ChartXAxis *xAxis = _lineChartView.xAxis;
    xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularityEnabled = YES;//设置重复的值不显示
    xAxis.granularity = 1.0;
    xAxis.axisLineColor = kColorTableViewSeparatorLine;
    xAxis.labelTextColor = UIColor.clearColor;
    
    ChartMarkerView *markerY = [[ChartMarkerView alloc] init];
    markerY.offset = CGPointMake(-40, -50);
    markerY.chartView = _lineChartView;
    _lineChartView.marker = markerY;
    [markerY addSubview:self.markY];
    
    //描述及图例样式
    self.lineChartView.chartDescription.enabled = NO;
    [_lineChartView setExtraOffsetsWithLeft:0 top:10 right:30 bottom:10];
    
    
    [self addSubview:self.lineChartView];
    [self.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}




- (void)setData{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 30; i++){
        double val = arc4random_uniform(30) + 53;
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = nil;
    set1 = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet 1"];
    set1.mode = LineChartModeLinear;
    set1.drawValuesEnabled = NO;
    set1.drawCirclesEnabled = NO;
    [set1 setColor:[UIColor colorWithHexString:@"0x93BF67"]];
    set1.lineWidth = 1.0;
    set1.highlightEnabled = YES;

    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    _lineChartView.data = data;
}





- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    _markY.text = [NSString stringWithFormat:@"   2018/03/14\n   当日功耗:12.5W"];

    [_lineChartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_lineChartView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:0.5];
}




- (UILabel *)markY{
    if (!_markY) {
        _markY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 60)];
        _markY.font = [UIFont systemFontOfSize:14.0];
        _markY.layer.cornerRadius = 5;
        _markY.layer.masksToBounds = YES;
        _markY.numberOfLines = 2;
        _markY.textAlignment = NSTextAlignmentLeft;
        _markY.textColor = [UIColor whiteColor];
        _markY.backgroundColor = [UIColor colorWithHexString:@"0x93BF67"];
    }
    return _markY;
}







@end
