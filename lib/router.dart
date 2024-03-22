import 'package:front_have_a_meal/features/account/sign_in_screen.dart';
import 'package:front_have_a_meal/features/account/sign_up_screen.dart';
import 'package:front_have_a_meal/features/user/user_navigation_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: SignInScreen.routeURL,
    name: SignInScreen.routeName,
    builder: (context, state) {
      return const SignInScreen();
    },
  ),
  GoRoute(
    path: SignUpScreen.routeURL,
    name: SignUpScreen.routeName,
    builder: (context, state) {
      return const SignUpScreen();
    },
  ),
  GoRoute(
    path: UserNavigationScreen.routeURL,
    name: UserNavigationScreen.routeName,
    builder: (context, state) {
      if (state.extra != null) {
        final args = state.extra as UserNavigationScreenArgs;
        return UserNavigationScreen(
          selectedIndex: args.selectedIndex,
        );
      }
      return const UserNavigationScreen(selectedIndex: 0);
    },
  ),
]);
