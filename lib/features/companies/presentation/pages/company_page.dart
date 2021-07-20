import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioasys_tdd/features/companies/presentation/bloc/companies_bloc.dart';

class Company extends StatelessWidget {
  const Company({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CompaniesBloc, CompaniesState>(
        builder: (context, state) {
          if (state is CompaniesInitial) {
            return Container(
              child: Center(
                child: Text('Initial'),
              ),
            );
          } else if (state is CompaniesLoading) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CompaniesLoaded) {
            return Container(
              child: Center(
                child: Text(
                  state.enterprises.length.toString(),
                ),
              ),
            );
          } else if (state is CompaniesError) {
            return Container(
              child: Center(
                child: Text(state.message),
              ),
            );
          }
          return Container(
            child: Center(
              child: Text('nada'),
            ),
          );
        },
      ),
    );
  }
}
