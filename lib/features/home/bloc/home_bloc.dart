import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocpattern/data/cart_item.dart';
import 'package:blocpattern/data/grocery_data.dart';
import 'package:blocpattern/data/wishlist_items.dart';
import 'package:blocpattern/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

//enum Counter

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    //kaha hn hn bhai yr to jani ijj kkkk h hhh h cckfc jjc nh kcc
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);

    on<IncreamentEvent>(increamentEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadingSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(e['id'], e['name'], e['category'],
                e['price'], e['quantity'], e['imageUrl']))
            .toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Wishlist Product Clicked");

    print('--------------------------');
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Cart Product Clicked");

    print("--------------------");
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistPageActionState());
    print("Wish Naviagte Clicked");
    print('----------------------');
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
    print('Cart navigate clicked');
  }

  FutureOr<void> increamentEvent(
      IncreamentEvent event, Emitter<HomeState> emit) async* {
    if (event is IncreamentEvent) {
      final currentState = state as CounterState;
      final newCount = currentState.count + 1;

      yield CounterState(newCount);
    }
  }
}
