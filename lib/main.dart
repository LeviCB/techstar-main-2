
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:techstar/screens/authentication/change_password.dart';
import 'package:techstar/screens/authentication/forgot_password.dart';
import 'package:techstar/screens/authentication/login_screen.dart';
import 'package:techstar/screens/authentication/reset_password.dart';
import 'package:techstar/screens/authentication/signup_screen.dart';
import 'package:techstar/screens/home/feeds/story_view.dart';
import 'package:techstar/screens/home/home_screen.dart';
import 'package:techstar/screens/home/message/chatting_screen.dart';
import 'package:techstar/screens/home/message/group/create_group_screen.dart';
import 'package:techstar/screens/home/notification/pending_request_screen.dart';
import 'package:techstar/screens/home/profile/editprofile_screen.dart';
import 'package:techstar/screens/home/profile/followers_following/followers_following_screen.dart';
import 'package:techstar/screens/home/profile/settings_screen.dart';
import 'package:techstar/screens/home/profile/single_post_screen.dart';
import 'package:techstar/screens/others/friend_profile_screen.dart';
import 'package:techstar/screens/others/search_friends_screen.dart';
import 'package:techstar/screens/home/message/group/select_group_member_screen.dart';
import 'package:techstar/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff008c00),
        primaryColorLight: const Color.fromARGB(255, 43, 168, 43),
        scaffoldBackgroundColor: const Color.fromARGB(255, 16, 26, 32),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff008c00),
          secondary: const Color.fromARGB(255, 16, 26, 32).withOpacity(0.2),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 16, 26, 32),
        ),
      ),
      initialRoute: SplashScreen.routeName,
      getPages: [
        GetPage(
          name: SplashScreen.routeName,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: SignupScreen.routeName,
          page: () => const SignupScreen(),
        ),
        GetPage(
          name: ChattingScreen.routeName,
          page: () => const ChattingScreen(),
        ),
        GetPage(
          name: SinglePostScreen.routeName,
          page: () => const SinglePostScreen(),
        ),
        GetPage(
          name: SettingsSceen.routeName,
          page: () => const SettingsSceen(),
        ),
        GetPage(
          name: EditprofileScreen.routeName,
          page: () => const EditprofileScreen(),
        ),
        GetPage(
          name: StoryViewScreen.routeName,
          page: () => const StoryViewScreen(),
        ),
        GetPage(
          name: ForgotPasswordScreen.routeName,
          page: () => const ForgotPasswordScreen(),
        ),
        GetPage(
          name: ChangePasswordScreen.routeName,
          page: () => const ChangePasswordScreen(),
        ),
        GetPage(
          name: ResetPasswordScreen.routeName,
          page: () => const ResetPasswordScreen(),
        ),
        GetPage(
          name: SearchFriendsScreen.routeName,
          page: () => const SearchFriendsScreen(),
        ),
        GetPage(
          name: FollowersFollowingScreen.routeName,
          page: () => const FollowersFollowingScreen(),
        ),
        GetPage(
          name: PendingRequestScreen.routeName,
          page: () => const PendingRequestScreen(),
        ),
        GetPage(
          name: FriendProfileScreen.routeName,
          page: () => const FriendProfileScreen(),
        ),
        GetPage(
          name: CreateGroupScreen.routeName,
          page: () => const CreateGroupScreen(),
        ),
        GetPage(
          name: SelectGroupMemberScreen.routeName,
          page: () => const SelectGroupMemberScreen(),
        ),
      ],
    );
  }
}
