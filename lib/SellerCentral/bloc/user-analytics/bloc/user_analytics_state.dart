part of 'user_analytics_bloc.dart';

class UserAnalyticsState extends Equatable {
  const UserAnalyticsState(this.userAnalyticsModel, this.error);

  final UserAnalyticsModel userAnalyticsModel;
  final String error;

  @override
  List<Object> get props => [userAnalyticsModel];
  UserAnalyticsState copyWith({
    UserAnalyticsModel? userAnalyticsModel,
    String? error,
  }) {
    return UserAnalyticsState(
      userAnalyticsModel ?? this.userAnalyticsModel,
      error ?? this.error,
    );
  }
}
