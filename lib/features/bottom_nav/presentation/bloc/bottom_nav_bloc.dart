import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../login_screen/domain/entities/login_user.dart';
import '../../domain/usecases/navigate_to_category.dart';
import '../../domain/usecases/navigate_to_dashbaord.dart';
import '../../domain/usecases/navigate_to_news_feed.dart';
import '../../domain/usecases/navigate_to_privacy_laws.dart';
import '../../domain/usecases/navigate_to_privacy_tips.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  final NavigateToNewsFeed navigateToNewsFeed;
  final NavigateToCategory navigateToCategory;
  final NavigateToDashboard navigateToDashboard;
  final NavigateToPrivacyTips navigateToPrivacyTips;
  final NavigateToPrivacyLaws navigateToPrivacyLaws;

  BottomNavBloc(
      {@required this.navigateToNewsFeed,
      @required this.navigateToCategory,
      @required this.navigateToDashboard,
      @required this.navigateToPrivacyTips,
      @required this.navigateToPrivacyLaws});

  @override
  BottomNavState get initialState => Initial();

  @override
  Stream<BottomNavState> mapEventToState(
    BottomNavEvent event,
  ) async* {
    if (event is NewsFeedEvent) {
      yield Loading();
      final response = await this.navigateToNewsFeed(event.user);
      yield response.fold(
        (faliure) => InternetError(event: event),
        (user) => NewsFeedState(user: user),
      );
    } else if (event is CategoryEvent) {
      yield Loading();
      final response = await this.navigateToCategory(event.user);
      yield response.fold(
        (faliure) => InternetError(event: event),
        (user) => CategoryState(user: user),
      );
    } else if (event is DashboardEvent) {
      yield Loading();
      final response = await this.navigateToDashboard(event.user);
      yield response.fold(
        (faliure) => InternetError(event: event),
        (user) => DashboardState(user: user),
      );
    }
    if (event is TipsEvent) {
      yield Loading();
      final response = await this.navigateToPrivacyTips(event.user);
      yield response.fold(
        (faliure) => InternetError(event: event),
        (user) => PrivacyTipsState(user: user),
      );
    }
    if (event is LawsEvent) {
      yield Loading();
      final response = await this.navigateToPrivacyLaws(event.user);
      yield response.fold(
        (faliure) => InternetError(event: event),
        (user) => PrivacyLawsState(user: user),
      );
    }
  }
}
