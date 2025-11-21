import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasisparents/core/reusable_components/app_colors_extension.dart';
import 'package:oasisparents/core/reusable_components/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/assets_manager.dart';
import '../../core/model/loginModels/LoginResponse.dart';
import '../../core/reusable_components/login_background.dart';
import '../../core/reusable_components/role_selector.dart';
import '../../core/reusable_components/toastErrorMsg.dart';
import '../../core/services/loginServices/AuthLoginService.dart';
import '../../core/strings_manager.dart';
import '../home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Save token + username
Future<void> saveUserData(String token, String empName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", token);
  await prefs.setString("empName", empName);
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late TextEditingController userController;
  late TextEditingController passController;
  late TextEditingController mailController;
  late GlobalKey<FormState> formKey;

  UserRole? selectedRole;
  late FocusNode userFocusNode;

  static const String emailRegex =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$";

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    userController = TextEditingController();
    passController = TextEditingController();
    mailController = TextEditingController();

    userFocusNode = FocusNode();
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    mailController.dispose();
    userFocusNode.dispose();
    super.dispose();
  }

  bool get _inputsEnabled => selectedRole != null;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (details) {
          final result = HitTestResult();
          WidgetsBinding.instance.hitTest(result, details.globalPosition);

          final tappedEditable = result.path.any((hit) {
            final name = hit.target.runtimeType.toString();
            return name.contains("RenderEditable");
          });

          if (!tappedEditable) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            // ⭐ NEW sportive-education animated login background
            LoginBackground(showTopBlueBar: false),

            // 🌍 Language button
            Positioned(
              top: 40,
              right: 20,
              child: PopupMenuButton<Locale>(
                icon: Icon(Icons.language, color: scheme.elements),
                onSelected: (Locale locale) => context.setLocale(locale),
                itemBuilder: (_) => const [
                  PopupMenuItem(value: Locale('en'), child: Text('🇬🇧 English')),
                  PopupMenuItem(value: Locale('fr'), child: Text('🇫🇷 Français')),
                ],
              ),
            ),

            // MAIN LOGIN UI
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Form(
                  key: formKey,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // LOGO
                        Image.asset(
                          AssetsManager.logo,
                          width: 150.w,
                        ),
                    
                        SizedBox(height: 18.h),
                    
                        // TITLE
                        Text(
                          "welcome".tr(),
                          style: TextStyle(
                            fontSize: 32.sp,
                            color: scheme.textMainBlack,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    
                        SizedBox(height: 6.h),
                    
                        // ROLE SELECTOR
                        RoleSelector(
                          initialRole: selectedRole,
                          onRoleChanged: (role) {
                            setState(() => selectedRole = role);
                          },
                        ),
                    
                        SizedBox(height: 20.h),
                    
                        // ROLE HINT
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 250),
                          opacity: selectedRole == null ? 1.0 : 0.0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Text(
                              selectedRole == null
                                  ? 'Please choose a role to continue'
                                  : '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: scheme.onSurface.withOpacity(0.6),
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ),
                    
                        SizedBox(height: 8.h),
                    
                        // USERNAME
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                          child: AbsorbPointer(
                            absorbing: !_inputsEnabled,
                            child: Opacity(
                              opacity: _inputsEnabled ? 1.0 : 0.65,
                              child: CustomTextField(
                                hint: "enter_user_id".tr(),
                                hintIcon: Icons.person,
                                controller: userController,
                                keyboardType: TextInputType.number,
                                validator: (_) => null,
                                focusNode: userFocusNode,
                                onTap: () {
                                  if (!userFocusNode.hasFocus) {
                                    userFocusNode.requestFocus();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                    
                        // PASSWORD
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                          child: AbsorbPointer(
                            absorbing: !_inputsEnabled,
                            child: Opacity(
                              opacity: _inputsEnabled ? 1.0 : 0.65,
                              child: CustomTextField(
                                hint: "enterPassword".tr(),
                                hintIcon: Icons.lock,
                                controller: passController,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "empty_password".tr();
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                    
                        // FORGOT PASSWORD
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => _openResetSheet(context, scheme),
                                child: Text(
                                  "forget_password".tr(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: scheme.textMainBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    
                        SizedBox(height: 28.h),
                    
                        // LOGIN BUTTON
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _inputsEnabled
                                ? scheme.elements
                                : Theme.of(context).disabledColor,
                            minimumSize: Size(330.w, 44.h),
                          ),
                          onPressed: !_inputsEnabled ? null : _loginPressed,
                          child: Text(
                            "login".tr(),
                            style: TextStyle(
                              color: _inputsEnabled
                                  ? scheme.textMainWhite
                                  : scheme.onSurface.withOpacity(0.6),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Forgot password bottom sheet
  void _openResetSheet(BuildContext context, ColorScheme scheme) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        color: scheme.backgroundMain,
        child: Column(
          children: [
            // HEADER
            Container(
              height: 56.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "reset".tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: scheme.textMainBlack,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: scheme.elements),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50.h),

            SizedBox(
              width: 350.w,
              child: CustomTextField(
                hint: "enter_email".tr(),
                hintIcon: Icons.email,
                controller: mailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "empty_email".tr();
                  }
                  if (!RegExp(emailRegex).hasMatch(value)) {
                    return "not_valid_email".tr();
                  }
                  return null;
                },
              ),
            ),

            SizedBox(height: 20.h),

            SizedBox(
              width: 350.w,
              child: Text(
                "reset_note".tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: scheme.textMainBlack,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: scheme.elements,
                minimumSize: Size(330.w, 40.h),
              ),
              onPressed: () {},
              child: Text(
                "reset".tr(),
                style: TextStyle(
                  color: scheme.textMainWhite,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// LOGIN LOGIC
  Future<void> _loginPressed() async {
    if (!formKey.currentState!.validate()) return;

    try {
      LoginResponse response = await AuthLoginService.login(
        username: userController.text,
        password: passController.text,
        deviceId: selectedRole.toString(),
        DeviceType: 1,
        fcmToken: "",
      );

      if (response.token != null && response.token!.isNotEmpty) {
        final userData =
        response.data != null && response.data!.isNotEmpty
            ? response.data!.first
            : null;

        final empName = userData?.fatherFullname ?? "";
        final token = response.token ?? "";

        await saveUserData(token, empName);

        Navigator.pushReplacementNamed(
          context,
          HomeScreen.routeName,
          arguments: {
            "empName": empName,
            "token": token,
            "role": selectedRole.toString(),
          },
        );
      } else {
        ToastMsg.toastErrorMsg(context, StringsManager.loginError.tr());
      }
    } catch (e) {
      ToastMsg.toastErrorMsg(context, StringsManager.networkError.tr());
    }
  }
}