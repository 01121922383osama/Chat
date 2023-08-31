class ObscureTextSate {
  final bool isDisAppear;
  const ObscureTextSate({
    this.isDisAppear = false,
  });
  ObscureTextSate copyWith({
    bool? isDisAppear,
  }) {
    return ObscureTextSate(
      isDisAppear: isDisAppear ?? this.isDisAppear,
    );
  }
}
