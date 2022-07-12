class Option<T> {
  const Option(this.value);
  const Option.none() : value = null;
  const Option.some(T value) : this.value = value;

  final T? value;

  bool get isSome => value != null;
  bool get isNone => value == null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other))
      return true;
    if (other.runtimeType != runtimeType)
      return false;
    return other is Option
        && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
