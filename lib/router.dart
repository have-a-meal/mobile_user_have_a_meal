import 'package:front_have_a_meal/features/account/pw_reset_auth_screen.dart';
import 'package:front_have_a_meal/features/account/pw_reset_screen.dart';
import 'package:front_have_a_meal/features/account/sign_in_screen.dart';
import 'package:front_have_a_meal/features/account/sign_up_screen.dart';
import 'package:front_have_a_meal/features/error/error_screen.dart';
import 'package:front_have_a_meal/features/pay/ticket_pay_screen.dart';
import 'package:front_have_a_meal/features/pay/ticket_pay_type_screen.dart';
import 'package:front_have_a_meal/features/profile/inform_view_screen.dart';
import 'package:front_have_a_meal/features/profile/infrom_update_screen.dart';
import 'package:front_have_a_meal/features/pay_check/pay_check_screen.dart';
import 'package:front_have_a_meal/features/profile/email_auth_screen.dart';
import 'package:front_have_a_meal/features/profile/setting_screen.dart';
import 'package:front_have_a_meal/features/pay_check/ticket_refund_screen.dart';
import 'package:front_have_a_meal/features/navigation_screen.dart';
import 'package:front_have_a_meal/features/menu/qr_use_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: SignInScreen.routeURL,
      name: SignInScreen.routeName,
      builder: (context, state) {
        return const SignInScreen();
      },
      routes: [
        GoRoute(
          path: SignUpScreen.routeURL,
          name: SignUpScreen.routeName,
          builder: (context, state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          path: PwResetAuthScreen.routeURL,
          name: PwResetAuthScreen.routeName,
          builder: (context, state) {
            return const PwResetAuthScreen();
          },
          routes: [
            GoRoute(
              path: PwResetScreen.routeURL,
              name: PwResetScreen.routeName,
              builder: (context, state) {
                return const PwResetScreen();
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: NavigationScreen.routeURL,
      name: NavigationScreen.routeName,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra as NavigationScreenArgs;
          return NavigationScreen(
            selectedIndex: args.selectedIndex,
          );
        }
        return const NavigationScreen(selectedIndex: 0);
      },
      routes: [
        GoRoute(
          path: TicketPayTypeScreen.routeURL,
          name: TicketPayTypeScreen.routeName,
          builder: (context, state) {
            if (state.extra != null) {
              final args = state.extra as TicketPayTypeScreenArgs;
              return TicketPayTypeScreen(
                ticketTime: args.ticketTime,
                ticketCourse: args.ticketCourse,
                ticketPrice: args.ticketPrice,
              );
            } else {
              return const ErrorScreen();
            }
          },
          routes: [
            GoRoute(
              path: TicketPayScreen.routeURL,
              name: TicketPayScreen.routeName,
              builder: (context, state) {
                if (state.extra != null) {
                  final args = state.extra as TicketPayScreenArgs;
                  return TicketPayScreen(
                    ticketTime: args.ticketTime,
                    ticketCourse: args.ticketCourse,
                    ticketPrice: args.ticketPrice,
                    payType: args.payType,
                  );
                } else {
                  return const ErrorScreen();
                }
              },
            ),
          ],
        ),
        GoRoute(
          path: QrUseScreen.routeURL,
          name: QrUseScreen.routeName,
          builder: (context, state) {
            // return const QrUseScreen();
            if (state.extra != null) {
              final args = state.extra as QrUseScreenArgs;
              return QrUseScreen(
                ticketTime: args.ticketTime,
                ticketCourse: args.ticketCourse,
              );
            } else {
              return const ErrorScreen();
            }
          },
        ),
        GoRoute(
          path: TicketRefundScreen.routeURL,
          name: TicketRefundScreen.routeName,
          builder: (context, state) {
            return const TicketRefundScreen();
          },
        ),
        GoRoute(
          path: PayCheckScreen.routeURL,
          name: PayCheckScreen.routeName,
          builder: (context, state) {
            return const PayCheckScreen();
          },
        ),
        GoRoute(
          path: SettingScreen.routeURL,
          name: SettingScreen.routeName,
          builder: (context, state) => const SettingScreen(),
          routes: [
            GoRoute(
              path: InfromViewScreen.routeURL,
              name: InfromViewScreen.routeName,
              builder: (context, state) {
                return const InfromViewScreen();
              },
              routes: [
                GoRoute(
                  path: EmailAuthScreen.routeURL,
                  name: EmailAuthScreen.routeName,
                  builder: (context, state) {
                    return const EmailAuthScreen();
                  },
                ),
                GoRoute(
                  path: InfromUpdateScreen.routeURL,
                  name: InfromUpdateScreen.routeName,
                  builder: (context, state) {
                    return const InfromUpdateScreen();
                  },
                  // builder: (context, state) {
                  //   if (state.extra != null) {
                  //     final args = state.extra as InfromUpdateScreenArgs;
                  //     return InfromUpdateScreen(
                  //       updateType: args.updateType,
                  //     );
                  //   } else {
                  //     return const InfromUpdateScreen(
                  //       updateType: UpdateType.pw,
                  //     );
                  //   }
                  // },
                )
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
