class PagedState<T> {
  final List<T> items;
  final bool loading; // first load
  final bool loadingMore; // next page
  final String? error;
  final bool hasMore;
  final int page;

  const PagedState({
    this.items = const [],
    this.loading = false,
    this.loadingMore = false,
    this.error,
    this.hasMore = true,
    this.page = 1,
  });

  PagedState<T> copyWith({
    List<T>? items,
    bool? loading,
    bool? loadingMore,
    String? error,
    bool? hasMore,
    int? page,
  }) {
    return PagedState<T>(
      items: items ?? this.items,
      loading: loading ?? this.loading,
      loadingMore: loadingMore ?? this.loadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
    );
  }
}
