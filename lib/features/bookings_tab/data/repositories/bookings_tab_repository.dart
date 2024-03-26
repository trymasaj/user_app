import 'package:masaj/features/bookings_tab/data/datasources/bookings_tab_remote_data_source.dart';

abstract class BookingsTabRepository {}

class BookingsTabRepositoryImpl implements BookingsTabRepository {
  final BookingRemoteDataSource _remoteDataSource;

  BookingsTabRepositoryImpl({
    required BookingRemoteDataSource bookings_tabRemoteDataSource,
  }) : _remoteDataSource = bookings_tabRemoteDataSource;
}
