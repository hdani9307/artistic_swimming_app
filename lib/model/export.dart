class ExportMeta {
  final int numberOfFragments;
  final int min;

  const ExportMeta({
    required this.numberOfFragments,
    required this.min,
  });

  Map<String, dynamic> toMap() => {"m": min, "f": numberOfFragments};
}

class ExportData {
  final int index;
  final List<int> diffs;

  const ExportData({
    required this.index,
    required this.diffs,
  });

  Map<String, dynamic> toMap() => {"i": index, "d": diffs};
}
