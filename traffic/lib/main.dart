import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/components.dart';
import 'package:traffic/resources/dimens.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/view_models/color_view_model.dart';
import 'package:traffic/view_models/controller.dart';
import 'package:traffic/view_models/forgot_password_view_model.dart';
import 'package:traffic/view_models/map_view_model.dart';
import 'package:traffic/view_models/register_view_model.dart';
import 'package:traffic/view_models/textstyle_view_model.dart';
import 'package:traffic/view_models/user_infor_view_model.dart';
import 'package:traffic/views/add_project.dart';
import 'package:traffic/views/edit_user_info.dart';
import 'package:traffic/views/forgot_password.dart';
import 'package:traffic/views/home_page.dart';
import 'package:traffic/views/list_project.dart';
import 'package:traffic/views/login.dart';
import 'package:traffic/views/project.dart';
import 'package:traffic/views/project_item.dart';
import 'package:traffic/views/register.dart';
import 'package:traffic/views/settings.dart';
import 'package:traffic/views/test_view.dart';
import 'package:traffic/views/user_infor.dart';
import 'package:traffic/views/view_map.dart';

import 'view_models/add_project_item_view_model.dart';
import 'view_models/add_project_view_model.dart';
import 'view_models/login_view_model.dart';
import 'view_models/project_detail.dart';
import 'views/welcome.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => ColorViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => RegisterViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => ForgotPasswordViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => TextStyleViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => MapViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => DetailProjectViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserInforViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => Controller(),
      ),
      ChangeNotifierProvider(
        create: (context) => AddProjectViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => AddProjectItemViewModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    ScreenSize.height = screenSize.height;
    ScreenSize.width = screenSize.width;

    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        themeMode: Provider.of<ColorViewModel>(context).isDarkMode ? ThemeMode.dark : ThemeMode.light,
        initialRoute: routeLogin,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case routeWelcome:
              return navigateToAScreen(const WelcomeScreen());
            case routeLogin:
              return navigateToAScreen(LoginScreen());
            case routeRegister:
              return navigateToAScreen(RegisterScreen());
            case routeForgotPassword:
              return navigateToAScreen(ForgotPasswordScreen());
            case routeHomePage:
              return navigateToAScreen(const HomePageScreen());
            case routeViewMapPage:
              return navigateToAScreen(const ViewMapScreen());
            case routeViewProjectPage:
              return navigateToAScreen(
                  const ProjectScreen(), settings.arguments);
            case routeViewProjectItemPage:
              return navigateToAScreen(
                  const ProjectItemScreen(), settings.arguments);
            case routeUserInfor:
              return navigateToAScreen(const UserInfoScreen());
            case routeSettings:
              return navigateToAScreen(SettingScreen());
            case routeEditUserInfor:
              return navigateToAScreen(EditUserInfoScreen());
            case routeViewListProject:
              return navigateToAScreen(const ListProjectScreen());
            case routeAddProject:
              return navigateToAScreen(AddNewProject());
            case '/test':
              return navigateToAScreen(const TestView());

            default:
              return null;
          }
        },
      ),
    );
  }
}
