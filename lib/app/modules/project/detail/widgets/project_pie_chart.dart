import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChart extends StatelessWidget {
  const ProjectPieChart({
    super.key,
    required this.projectEstimate,
    required this.totalTask,
  });

  final int projectEstimate;
  final int totalTask;

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context);

    final residual = projectEstimate - totalTask;

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.loose,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: totalTask.toDouble(),
                  color: themeColor.primaryColor,
                  showTitle: true,
                  title: '${totalTask}h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  value: residual.toDouble(),
                  color: themeColor.primaryColorLight,
                  showTitle: true,
                  title: '${residual}h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            child: Text(
              '${projectEstimate}h',
              style: TextStyle(
                fontSize: 25,
                color: themeColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
