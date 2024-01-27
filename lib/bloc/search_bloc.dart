import 'package:b_sell/main.dart';
import 'package:b_sell/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Product> products;

  SearchLoaded(this.products);
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}

class SearchEvent {}

class PerformSearch extends SearchEvent {
  final String query;

  PerformSearch(this.query);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is PerformSearch) {
      yield SearchLoading();

      try {
        List<Product> products = await _searchProducts(event.query);
        yield SearchLoaded(products);
      } catch (e) {
        yield SearchError("Error loading products: $e");
      }
    } else {
      yield SearchInitial();
    }
  }

  Future<List<Product>> _searchProducts(String query) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z') // You may need to adjust this based on your data
        .get();

    List<Product> products = querySnapshot.docs
        .map((doc) => Product(
              id: doc.id,
              name: doc['name'],
              price: doc['price'],
              description: doc['description'],
              type: doc['type'],
              imageUrl: doc['imageUrl'],
              likesCount: doc['likesCount'],
            ))
        .toList();
    logger.i(products);
    return products;
  }
}
