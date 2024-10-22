import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:word_generator/my_button.dart';
import 'package:word_generator/my_card.dart';
import 'package:word_generator/my_list_item.dart';

void main() {
  runApp(const MyApp());
}

List<WordPair> favorites = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        '/home/': (context) => const MyHomePage(),
        '/favorites/': (context) => const FavoritesPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WordPair _word = WordPair.random();
  Icon icon = const Icon(Icons.favorite_border);

  changeWord() {
    setState(() {
      _word = WordPair.random();
      icon = const Icon(Icons.favorite_border);
    });
  }

  favoriteWord() {
    if (favorites.contains(_word)) {
      favorites.remove(_word);
      setState(() {
        icon = const Icon(Icons.favorite_border);
      });
    } else {
      favorites.add(_word);
      setState(() {
        icon = const Icon(Icons.favorite);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.more_horiz),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyCard(text: _word.asPascalCase),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  onPressed: () {
                    favoriteWord();
                  },
                  text: const Text("Like"),
                  icon: icon,
                ),
                const SizedBox(width: 30),
                MyButton(
                  onPressed: () {
                    changeWord();
                  },
                  text: const Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text("Home"),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/home/',
                (route) => false,
              );
            },
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/favorites/',
                (route) => false,
              );
            },
            title: const Text("Favorites"),
            leading: const Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites Page"),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.more_horiz),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return MyListItem(text: favorites[index].asPascalCase);
        },
      ),
      drawer: const MyDrawer(),
    );
  }
}
