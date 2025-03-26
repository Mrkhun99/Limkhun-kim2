enum AsyncState { loading, success, error }

class AsyncValue<T> {
  final AsyncState _state;
  final T? _data;
  final Object? _error;

  AsyncValue.loading()
      : _state = AsyncState.loading,
        _data = null,
        _error = null;

  AsyncValue.success(T data)
      : _state = AsyncState.success,
        _data = data,
        _error = null;

  AsyncValue.error(Object error)
      : _state = AsyncState.error,
        _data = null,
        _error = error;

  bool get isLoading => _state == AsyncState.loading;
  bool get isSuccess => _state == AsyncState.success;
  bool get isError => _state == AsyncState.error;

  T? get data => _data;
  Object? get error => _error;

  void when({
    required Function() loading,
    required Function(T data) success,
    required Function(Object error) error,
  }) {
    switch (_state) {
      case AsyncState.loading:
        loading();
        break;
      case AsyncState.success:
        success(_data as T);
        break;
      case AsyncState.error:
        error(_error!);
        break;
    }
  }
}