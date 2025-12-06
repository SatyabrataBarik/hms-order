import 'package:get_it/get_it.dart';
import 'package:hms/data/order_repository/cart_items_repository.dart';
import 'package:hms/data/order_repository/order_details_view.dart';
import 'package:hms/view_model/cart_view_model.dart';
import 'package:hms/view_model/order_details_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<OrderDetailsViewRepository>(
    () => OrderDetailsViewRepository(),
  );

  locator.registerLazySingleton<CartItemRepository>(() => CartItemRepository());

  locator.registerFactory<OrderDetailsViewModel>(
    () => OrderDetailsViewModel(locator.get<OrderDetailsViewRepository>()),
  );

  locator.registerFactory<CartViewModel>(
    () => CartViewModel(repo: locator.get<CartItemRepository>()),
  );
}
