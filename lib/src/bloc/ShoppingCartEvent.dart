import 'package:equatable/equatable.dart';

abstract class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();
  @override
  List<Object> get props => [];
}

class ShoppingCartFetched extends ShoppingCartEvent {}

class ShoppingCartItemRemoved extends ShoppingCartEvent {
  const ShoppingCartItemRemoved(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
