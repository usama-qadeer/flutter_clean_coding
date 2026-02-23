class PageParams {
  final int page;
  final int limit;

  const PageParams({required this.page, this.limit = 20});

  Map<String, dynamic> toQuery() => {'page': page, 'limit': limit};
}
