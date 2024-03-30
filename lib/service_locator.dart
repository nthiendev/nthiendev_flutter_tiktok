import 'package:get_it/get_it.dart';
import 'package:nthiendev_flutter_tiktok/view-models/feed_viewmodel.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerSingleton<FeedViewModel>(FeedViewModel());
}
