import '../infinite_listview_bloc.dart';

/// This code defines a class called Data that accepts a generic type [T].
/// The class has several properties:
/// [data]: A Map that stores lists of items of type [T] with integer keys.
/// [page]: An integer representing the current page number.
/// [totalPages]: An integer representing the total number of pages.
/// [limit]: An integer representing the maximum number of items per page.
/// [totalCount]: An integer representing the total number of items.
/// The class has a constructor that takes in the required parameter data and optional parameters for page, totalPages, limit, and totalCount. The optional parameters have default values in case they are not provided.
/// The class also has a copyWith method that returns a new instance of [Data] with updated values for the specified properties. It accepts optional parameters for data, page, totalPages, and limit and uses the ?? operator to determine whether to use the provided values or the existing values of the object.
/// Overall, this class provides a convenient way to store and manipulate data with pagination information.
class Data<T extends Object> {
  ///
  Data({
    required this.paged,
    this.page = 0,
    this.totalPages = 0,
    this.pageSize = 10,
    this.totalCount = 0,
  });

  ///
  factory Data.empty() => Data<T>(
        paged: {},
      );

  ///
  factory Data.from(Pagable<T> result) {
    return Data<T>(
      paged: {
        result.page: result.items,
      },
      page: result.page,
      pageSize: result.pageSize,
      totalPages: result.totalPages,
      totalCount: result.totalCount,
    );
  }

  ///
  final PagedData<T> paged;

  ///
  final int page;

  ///
  final int totalPages;

  ///
  final int pageSize;

  ///
  final int totalCount;

  ///
  Data<T> copyWith({
    PagedData<T>? paged,
    int? page,
    int? totalPages,
    int? pageSize,
    int? totalCount,
  }) {
    return Data<T>(
      paged: paged ?? this.paged,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  bool get isNextPageAvailable => page + 1 < totalPages;
}

enum Progress { loading, done }

///
typedef PagedData<T> = Map<int, Iterable<T>>;
typedef LoadingData = Map<int, Progress>;
