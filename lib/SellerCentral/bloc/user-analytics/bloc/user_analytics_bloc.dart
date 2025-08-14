import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pakmart/SellerCentral/repository/user-anaytics/model/user_analytics_model.dart';
import 'package:pakmart/SellerCentral/repository/user-anaytics/repo/user_analytics_repo.dart';

part 'user_analytics_event.dart';
part 'user_analytics_state.dart';

class UserAnalyticsBloc extends Bloc<UserAnalyticsEvent, UserAnalyticsState> {
  UserAnalyticsRepo userAnalyticsRepoHttp;
  Timer? _pollingTimer;

  UserAnalyticsBloc(this.userAnalyticsRepoHttp)
    : super(
        UserAnalyticsState(
          UserAnalyticsModel(
            freshLeads: 0,
            orderReceived: 0,
            orderClosed: 0,
            leadsRejected: 0,
          ),
          "",
        ),
      ) {
    on<FetchUserAnalyticsEvent>(_fetchUserAnalytics);
    on<StartPollingUserAnalyticsEvent>(_startPolling);
  }

  void _fetchUserAnalytics(
    FetchUserAnalyticsEvent event,
    Emitter<UserAnalyticsState> emit,
  ) async {
    await userAnalyticsRepoHttp
        .fetchUserAnalytics()
        .then((value) {
          emit(state.copyWith(userAnalyticsModel: value));
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(error: error.toString()));
        });
  }

  void _startPolling(
    StartPollingUserAnalyticsEvent event,
    Emitter<UserAnalyticsState> emit,
  ) {
    add(const FetchUserAnalyticsEvent());
    _pollingTimer?.cancel(); // Ensure no multiple timers
    _pollingTimer = Timer.periodic(Duration(seconds: event.intervalInSeconds), (
      _,
    ) {
      print("Polling User Analytics");
      add(const FetchUserAnalyticsEvent());
    });
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    return super.close();
  }
}
