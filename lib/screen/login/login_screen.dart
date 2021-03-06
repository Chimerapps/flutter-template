import 'package:flutter_template/widget/general/styled/flutter_template_progress_indicator.dart';
import 'package:flutter_template/widget/provider/provider_widget.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_template/navigator/main_navigator.dart';
import 'package:flutter_template/styles/theme_dimens.dart';
import 'package:flutter_template/util/keys.dart';
import 'package:flutter_template/viewmodel/error_navigator.dart';
import 'package:flutter_template/viewmodel/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/widget/general/status_bar.dart';
import 'package:flutter_template/widget/general/styled/flutter_template_button.dart';
import 'package:flutter_template/widget/general/styled/flutter_template_input_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

@visibleForTesting
class LoginScreenState extends State<LoginScreen> with ErrorNavigatorMixin implements LoginNavigator {
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'LoginScaffoldKey');

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LoginViewModel>(
      create: () => KiwiContainer().resolve()..init(this),
      childBuilder: (context, theme, _) => Consumer<LoginViewModel>(
        builder: (context, viewModel, child) => StatusBar.light(
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: theme.colorsTheme.backgroundDark,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(ThemeDimens.padding16),
                child: Column(
                  children: [
                    Container(height: ThemeDimens.padding16),
                    Text(
                      'Login',
                      style: theme.lightTextTheme.titleNormal,
                      textAlign: TextAlign.center,
                    ),
                    Container(height: ThemeDimens.padding32),
                    Text(
                      'Just fill in some text. There is no validator for the login',
                      style: theme.lightTextTheme.labelButtonSmall,
                    ),
                    Container(height: ThemeDimens.padding32),
                    FlutterTemplateInputField(
                      key: Keys.emailInput,
                      enabled: !viewModel.isLoading,
                      onChanged: viewModel.onEmailUpdated,
                      hint: 'Email',
                    ),
                    Container(height: ThemeDimens.padding16),
                    FlutterTemplateInputField(
                      key: Keys.passwordInput,
                      enabled: !viewModel.isLoading,
                      onChanged: viewModel.onPasswordUpdated,
                      hint: 'Password',
                    ),
                    Container(height: ThemeDimens.padding16),
                    if (viewModel.isLoading) ...{
                      const FlutterTemplateProgressIndicator.light(),
                    } else
                      FlutterTemplateButton(
                        key: Keys.loginButton,
                        isEnabled: viewModel.isLoginEnabled,
                        text: 'Login',
                        onClick: viewModel.onLoginClicked,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ScaffoldState getScaffoldState() => _scaffoldKey.currentState;

  @override
  void goToHome() => MainNavigatorWidget.of(context).goToHome();
}
