import 'package:flutter/material.dart';
import 'package:sieve_data_privacy_app/features/login_screen/domain/entities/login_user.dart';
import '../../features/login_signup_screen/presentation/pages/login_signup_screen.dart';
import '../../features/suggestion/presentation/pages/suggestion.dart';

import '../../features/login_screen/data/datasources/login_screen_local_datasource.dart';
import '../../injection_container.dart';

class SuggAndLogout extends StatelessWidget {
  final String title;
  final IconData icon;
  final LoginUser user;

  final LoginScreenLocalDataSource _loginScreenLocalDataSource =
      sl<LoginScreenLocalDataSource>();

  SuggAndLogout({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _suggestionOnTap(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 48,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
          ),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 1.5,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _suggestionOnTap(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Suggestion(user: user)));
  }

}
