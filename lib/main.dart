import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_query/providers/fetch_characters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GRAPHQL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FLUTTER GRAPHQL'),
      ),
      body: ref.watch(fetchCharacterProvider).maybeWhen(
            fetched: (characters) {
              return ListView(
                children: characters
                    .map(
                      (e) => ListTile(
                        title: Text(e.name ?? ''),
                        leading: Image.network(
                          (e.image ?? ''),
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        subtitle: Text(e.status ?? ''),
                      ),
                    )
                    .toList(),
              );
            },
            fetching: () => const Center(
              child: CupertinoActivityIndicator(),
            ),
            failed: (error) {
              return Center(child: Text(error));
            },
            
            orElse: () {
              return Center(child: Text('sth else'));
            },
          ),
    );
  }
}
