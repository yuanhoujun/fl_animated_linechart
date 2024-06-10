import 'dart:ui';

import 'package:fl_animated_linechart/chart/chart_line.dart';
import 'package:fl_animated_linechart/chart/chart_point.dart';
import 'package:fl_animated_linechart/common/dates.dart';
import 'package:fl_animated_linechart/common/pair.dart';

class IntSeriesConverter {
  static Pair<List<ChartLine>, FromTo> convertFromIntMaps(
      List<Map<int, int>> series, List<Color> colors, List<String> units) {
    FromTo minMax = _findMinMax(series);

    int index = 0;
    List<ChartLine> lines = series
        .map((map) => _convert(map, minMax, colors[index], units[index++]))
        .toList();

    return Pair(lines, minMax);
  }

  static ChartLine _convert(
      Map<int, int> input, FromTo minMax, Color color, String unit) {
    List<ChartPoint> result = [];

    input.forEach((x, y) {
      result.add(ChartPoint(x.toDouble(), y.toDouble()));
    });

    return ChartLine(result, color, unit);
  }

  static FromTo _findMinMax(List<Map<int, int>> list) {
    int? min;
    int? max;

    list.forEach((map) {
      map.keys.forEach((x) {
        if (min == null) {
          min = x;
          max = x;
        } else {
          if (x < min!) {
            min = x;
          }
          if (x > max!) {
            max = x;
          }
        }
      });
    });

    return FromTo(min, max);
  }
}
