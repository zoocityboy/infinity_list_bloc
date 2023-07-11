/// Pagable class
///
/// - totalCount
/// - totalPages
/// - page
/// - pageSize
class Pagable<T> {
  const Pagable({
    required this.totalCount,
    required this.totalPages,
    required this.page,
    required this.pageSize,
    this.items = const [],
  });
  final int totalCount;
  final int totalPages;
  final int page;
  final int pageSize;
  final List<T> items;
}
