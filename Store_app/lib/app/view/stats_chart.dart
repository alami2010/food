/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vender/app/controller/stats_chart_controller.dart';
import 'package:vender/app/util/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsChartScreen extends StatefulWidget {
  const StatsChartScreen({Key? key}) : super(key: key);

  @override
  State<StatsChartScreen> createState() => _StatsChartScreenState();
}

class _StatsChartScreenState extends State<StatsChartScreen> {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  // double? _crossAt;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatsChartsController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeProvider.whiteColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Chart View'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Orders Trends'.tr,
                style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildTodaysChart(),
              const SizedBox(
                height: 10,
              ),
              _buildWeekyChart(),
              const SizedBox(
                height: 10,
              ),
              _buildMonthlyChart(),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Month's distribution of your orders".tr,
                style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            'Menu items'.tr,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Quantity Sold'.tr,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (var item in value.topOrders)
                    dishMenu(
                        item.items!.name.toString(), item.counts.toString())
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              _buildDefaultDoughnutChart()
            ],
          ),
        )),
      );
    });
  }

  Widget dishMenu(String left, String right) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              // ,
              left.length > 25
                  ? '${left.substring(0, 25)}...'
                  : left.toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Text(
              right,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  SfCircularChart _buildDefaultDoughnutChart() {
    return SfCircularChart(
      legend:
          Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
      series: _getDefaultDoughnutSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '10%',
          dataSource: <ChartSampleData>[
            for (var item in Get.find<StatsChartsController>().topOrders)
              ChartSampleData(
                  x: item.items!.name.toString(),
                  y: item.counts,
                  text: item.items!.name.toString()),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
  }

  SfCartesianChart _buildTodaysChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Total number of orders today'.tr,
          textStyle: const TextStyle(fontSize: 10)),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat:
              '{value}${Get.find<StatsChartsController>().currencySymbol}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getTodaysData(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  SfCartesianChart _buildWeekyChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Total number of orders weekly'.tr,
          textStyle: const TextStyle(fontSize: 10)),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat:
              '{value}${Get.find<StatsChartsController>().currencySymbol}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getWeekData(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  SfCartesianChart _buildMonthlyChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Total number of orders monthly'.tr,
          textStyle: const TextStyle(fontSize: 10)),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat:
              '{value}${Get.find<StatsChartsController>().currencySymbol}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getMonthlyData(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<ColumnSeries<ChartSampleData, String>> _getTodaysData() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          for (var item in Get.find<StatsChartsController>().todayStatesCharts)
            ChartSampleData(
                x: item.date,
                y: item.totalSell,
                pointColor: ThemeProvider.appColor),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getWeekData() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          for (var item in Get.find<StatsChartsController>().weeekStatesCharts)
            ChartSampleData(
                x: item.date,
                y: item.totalSell,
                pointColor: ThemeProvider.appColor),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getMonthlyData() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          for (var item in Get.find<StatsChartsController>().monthStatsCharts)
            ChartSampleData(
                x: item.date,
                y: item.totalSell,
                pointColor: ThemeProvider.appColor),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}

class ChartSampleData {
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  final dynamic x;

  final num? y;

  final dynamic xValue;

  final num? yValue;

  final num? secondSeriesYValue;

  final num? thirdSeriesYValue;

  final Color? pointColor;

  final num? size;

  final String? text;

  final num? open;

  final num? close;

  final num? low;

  final num? high;

  final num? volume;
}
