// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-bloc';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Chip(
          label: Text(
            'Current Playlist',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          side: BorderSide.none,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/iu-radio-app-logo.png', height: 200),
              const SizedBox(height: 20),
              BlocConsumer<HomeBloc, HomeState>(
                bloc: _homeBloc,
                listener: (context, state) {
                  if (state is HomeFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to switch playing state'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  String title = 'Unknown Title';
                  String interpret = 'Unknown Interpret';
                  bool isPlaying = false;

                  if (state is HomeSuccessState) {
                    title = state.title;
                    interpret = state.interpret;
                    isPlaying = state.isPlaying;
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Song: $title',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Interpret: $interpret',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              // Implementiere Logik für den linken Button
                            },
                            child: const Icon(Icons.lyrics),
                          ),
                          const SizedBox(width: 20),
                          FloatingActionButton(
                            onPressed: () {
                              _homeBloc.add(PlayButton());
                            },
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                          const SizedBox(width: 20),
                          FloatingActionButton(
                            onPressed: () {
                              // Implementiere Logik für den rechten Button
                            },
                            child: const Icon(Icons.grade),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
