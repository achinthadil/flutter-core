import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../init_dependencies.dart';
import '../blocs/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = serviceLocator<HomeBloc>();

  @override
  void initState() {
    super.initState();
    _homeBloc.add(LoadProducts());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppUserCubit, AppUserState>(
          listener: (context, state) {
            if (state is AppUserInitial) {
              context.go(CoreRoutePaths.signin);
            }
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure)),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AppUserCubit>().logout();
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            debugPrint('State 😂:: $state');
            if (state is HomeLoading) {
              return const Loader();
            } else if (state is HomeSuccess) {
              return ListView.builder(
                itemCount: state.productList.products?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = state.productList.products?[index];
                  return ListTile(
                    title: Text(product?.title ?? ''),
                    subtitle: Text("Price: ${product?.price}"),
                  );
                },
              );
            } else if (state is HomeFailure) {
              return Center(child: Text(state.failure));
            }
            return const Center(child: Text('Welcome to the Home Screen!'));
          },
        ),
      ),
    );
  }
}
