import 'package:front_have_a_meal/features/account/id_pw_search_screen.dart';
import 'package:front_have_a_meal/features/account/sign_in_screen.dart';
import 'package:front_have_a_meal/features/account/sign_up_screen.dart';
import 'package:front_have_a_meal/features/error/error_screen.dart';
import 'package:front_have_a_meal/features/outsider/outsider_navigation_screen.dart';
import 'package:front_have_a_meal/features/student/menu/student_menu_pay_screen.dart';
import 'package:front_have_a_meal/features/student/pay/student_ticket_pay_screen.dart';
import 'package:front_have_a_meal/features/student/student_navigation_screen.dart';
import 'package:front_have_a_meal/features/student/ticket/student_qr_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
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
      path: IdPwSearchScreen.routeURL,
      name: IdPwSearchScreen.routeName,
      builder: (context, state) {
        return const IdPwSearchScreen();
      },
    ),
    GoRoute(
      path: StudentNavigationScreen.routeURL,
      name: StudentNavigationScreen.routeName,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra as StudentNavigationScreenArgs;
          return StudentNavigationScreen(
            selectedIndex: args.selectedIndex,
          );
        }
        return const StudentNavigationScreen(selectedIndex: 0);
      },
      routes: [
        GoRoute(
          path: StudentMenuPayScreen.routeURL,
          name: StudentMenuPayScreen.routeName,
          builder: (context, state) {
            if (state.extra != null) {
              final args = state.extra as StudentMenuPayScreenArgs;
              return StudentMenuPayScreen(
                time: args.time,
                course: args.course,
                price: args.price,
              );
            } else {
              return const StudentMenuPayScreen(
                time: "중식",
                course: "B코스",
                price: "0",
              );
            }
          },
          routes: [
            GoRoute(
              path: StudentTicketPayScreen.routeURL,
              name: StudentTicketPayScreen.routeName,
              builder: (context, state) {
                if (state.extra != null) {
                  final args = state.extra as StudentTicketPayScreenArgs;
                  return StudentTicketPayScreen(
                    menuTime: args.menuTime,
                    menuCourse: args.menuCourse,
                    menuPrice: args.menuPrice,
                  );
                } else {
                  return const ErrorScreen();
                }
              },
            ),
          ],
        ),
        GoRoute(
          path: StudentQrScreen.routeURL,
          name: StudentQrScreen.routeName,
          builder: (context, state) {
            // return const StudentQrScreen();
            if (state.extra != null) {
              final args = state.extra as StudentQrScreenArgs;
              return StudentQrScreen(
                ticketTime: args.ticketTime,
                ticketCourse: args.ticketCourse,
              );
            } else {
              return const ErrorScreen();
            }
          },
        ),
      ],
    ),
    GoRoute(
      path: OutsiderNavigationScreen.routeURL,
      name: OutsiderNavigationScreen.routeName,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra as OutsiderNavigationScreenArgs;
          return OutsiderNavigationScreen(selectedIndex: args.selectedIndex);
        } else {
          return const OutsiderNavigationScreen(selectedIndex: 0);
        }
      },
    ),
  ],
);
