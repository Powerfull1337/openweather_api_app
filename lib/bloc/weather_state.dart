part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherFailure extends WeatherState {
  final String error;

  const WeatherFailure({required this.error});
  @override
  List<Object> get props => [error];
}

final class WeatherSuccess extends WeatherState {
  final Weather weather;

  const WeatherSuccess({required this.weather});
  @override
  List<Object> get props => [weather];
}
