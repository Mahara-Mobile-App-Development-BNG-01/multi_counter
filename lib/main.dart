import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => MultiCounterCubit(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final multiCounterCubit = context.watch<MultiCounterCubit>();

    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            multiCounterCubit.addCounter();
          },
        ),
        body: ListView.builder(
          itemCount: multiCounterCubit.state.length,
          itemBuilder: (context, index) {
            final counterValue = multiCounterCubit.state[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Counter Number: ${index + 1}'),
                        Text('Counter Value: ${counterValue}'),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            multiCounterCubit.increment(index);
                          },
                          icon: Icon(Icons.add),
                        ),
                        IconButton(
                          onPressed: () {
                            multiCounterCubit.decrement(index);
                          },
                          icon: Icon(Icons.remove),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MultiCounterCubit extends Cubit<List<int>> {
  MultiCounterCubit() : super([]);

  void addCounter() {
    emit([...state, 0]);
  }

  void increment(int index) {
    final newState = List.of(state);
    newState[index]++;
    emit(newState);
  }

  void decrement(int index) {
    final newState = List.of(state);
    newState[index]--;
    emit(newState);
  }
}
