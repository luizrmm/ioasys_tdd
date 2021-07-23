import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioasys_tdd/features/companies/presentation/bloc/companies_bloc.dart';

class Company extends StatelessWidget {
  const Company({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, inner) {
          return [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              floating: true,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    bottom: 60,
                    child: Image.asset(
                      'assets/header.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('44 resultados'),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          filled: true,
                          fillColor: Color(0xFFF5F5F5),
                          hintText: 'Pesquise por empresa',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              expandedHeight: 200,
              pinned: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 100,
            ),
          ];
        },
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
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    top: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: state.enterprises.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      height: 120,
                      child: Center(
                        child: Text(
                          state.enterprises[index].enterpriseName,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
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
      ),
    );
  }
}
