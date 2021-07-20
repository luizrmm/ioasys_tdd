import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioasys_tdd/features/companies/presentation/bloc/companies_bloc.dart';
import 'package:ioasys_tdd/features/companies/presentation/pages/company_page.dart';
import 'package:ioasys_tdd/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:ioasys_tdd/features/login/presentation/widgets/widgets.dart';
import 'package:ioasys_tdd/injection_container.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F5F5),
      body: buildBody(context),
    );
  }

  BlocProvider<AuthenticationBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LoginHeader(),
          SizedBox(
            height: 60,
          ),
          BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationLoaded) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) =>
                          sl<CompaniesBloc>()..add(GetAllEnterprisesEvent()),
                      child: Company(),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthenticationInitial) {
                return FormBody(
                  message: '',
                );
              } else if (state is AuthenticationError) {
                return FormBody(
                  message: state.message,
                );
              } else if (state is AuthenticationLoading) {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE01E69)),
                );
              }
              return FormBody(
                message: '',
              );
            },
          ),
        ],
      ),
    );
  }
}
