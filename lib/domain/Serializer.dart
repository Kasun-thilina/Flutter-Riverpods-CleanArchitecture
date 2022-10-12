class Serializer {
  static T fromJson<T>(dynamic json) {
    switch (T) {
      default:
        return json as T;
    }
  }
}
