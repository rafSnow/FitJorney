/// Extensões para formatação de valores double.
extension DoubleExt on double {
  /// Formata kg para exibição: 10.0 → "10 kg", 10.5 → "10.5 kg".
  String toKgString() {
    if (this == toInt().toDouble()) {
      return '${toInt()} kg';
    }
    return '${toStringAsFixed(1)} kg';
  }

  /// Formata para exibição sem unidade: remove .0 se inteiro.
  String toCleanString() {
    if (this == toInt().toDouble()) {
      return toInt().toString();
    }
    return toStringAsFixed(1);
  }
}
