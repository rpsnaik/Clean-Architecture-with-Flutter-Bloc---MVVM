import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_bloc.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_events.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_states.dart';

class RestaruntsScreen extends StatefulWidget {
  const RestaruntsScreen({super.key});

  @override
  State<RestaruntsScreen> createState() => _RestaruntsScreenState();
}

class _RestaruntsScreenState extends State<RestaruntsScreen> {
  late RestaruntsBloc restaruntsBloc;

  @override
  void initState() {
    restaruntsBloc = GetIt.I.get();
    restaruntsBloc.add(LoadRestaruntsEvent());
    super.initState();
  }

  @override
  void dispose() {
    restaruntsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restarunts Screen"),
      ),
      body: BlocBuilder(
        bloc: restaruntsBloc,
        builder: (context, state) {
          if (state is RestaruntsLoadError) {
            return Center(
              child: Text(state.errorMesage ?? "Something went wrong!"),
            );
          } else if (state is RestaruntsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RestaruntsLoaded) {
            return ListView.builder(
              itemCount: state.restarunts?.length ?? 0,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(state.restarunts?[i].name ?? ""),
                  subtitle: Text(state.restarunts?[i].cuisine ?? ""),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
