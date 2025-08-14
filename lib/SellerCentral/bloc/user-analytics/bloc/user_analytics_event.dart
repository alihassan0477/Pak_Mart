part of 'user_analytics_bloc.dart';

abstract class UserAnalyticsEvent extends Equatable {
  const UserAnalyticsEvent();

  @override
  List<Object> get props => [];
}

class FetchUserAnalyticsEvent extends UserAnalyticsEvent {
  const FetchUserAnalyticsEvent();
}

class StartPollingUserAnalyticsEvent extends UserAnalyticsEvent {
  final int intervalInSeconds;

  const StartPollingUserAnalyticsEvent({this.intervalInSeconds = 10});

  @override
  List<Object> get props => [intervalInSeconds];
}
