class DTCResultSummary {
  late final int timeUnderWater;
  late final int timeAboveWater;
  late final double underWaterRatio;
  late final int sessionLength;
  late final String sessionName;

  List<dynamic> toDynamic() => [
        timeUnderWater,
        timeAboveWater,
        underWaterRatio,
        sessionLength,
        sessionName,
      ];
}
