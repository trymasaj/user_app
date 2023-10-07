
import 'package:flutter/foundation.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/bookings_tab_repository.dart';
part 'bookings_tab_state.dart';

class BookingsTabCubit extends BaseCubit<BookingsTabState> {
  BookingsTabCubit({
    required BookingsTabRepository bookingsTabRepository,
  })  : _bookingsTabRepository = bookingsTabRepository,
        super(const BookingsTabState(status: BookingsTabStateStatus.initial));

  final BookingsTabRepository _bookingsTabRepository;
  

  
    }
  

