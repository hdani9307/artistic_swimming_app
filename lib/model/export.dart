class ExportMeta {
  final int numberOfFragments;
  final int min;
  final String name;

  const ExportMeta({
    required this.numberOfFragments,
    required this.min,
    required this.name,
  });

  Map<String, dynamic> toMap() => {"m": min, "f": numberOfFragments, "n": name};
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
