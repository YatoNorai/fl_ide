import 'package:routefly/routefly.dart';

import 'app/(public)/aplash_page.dart' as a0;
import 'app/(public)/code_page.dart' as a1;
import 'app/(public)/home_page.dart' as a2;
import 'app/(public)/settings_page.dart' as a3;

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/aplash',
    uri: Uri.parse('/aplash'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a0.SplashPage(),
    ),
  ),
  RouteEntity(
    key: '/code',
    uri: Uri.parse('/code'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a1.CodePage(),
    ),
  ),
  RouteEntity(
    key: '/home',
    uri: Uri.parse('/home'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a2.HomePage(),
    ),
  ),
  RouteEntity(
    key: '/settings',
    uri: Uri.parse('/settings'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a3.SettingsPage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  aplash: '/aplash',
  code: '/code',
  home: '/home',
  settings: '/settings',
);
