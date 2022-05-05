import 'package:flutter/material.dart';
import 'package:to_do_flutter/widgets/add_item.dart';
import 'package:to_do_flutter/widgets/to_do_list.dart';

void main() {
  final MaterialColor primaryColor = App.createMaterialColor(
        const Color.fromARGB(255, 176, 217, 236),
      ),
      secondaryColor = App.createMaterialColor(
        const Color.fromARGB(255, 79, 45, 34),
      );
  runApp(
    App(
      primarySwatch: primaryColor,
      secondarySwatch: secondaryColor,
    ),
  );
}

class App extends StatelessWidget {
  final MaterialColor primarySwatch;
  final MaterialColor secondarySwatch;

  const App(
      {Key? key, required this.primarySwatch, required this.secondarySwatch})
      : super(key: key);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: primarySwatch,
                  primaryColorDark: secondarySwatch)
              .copyWith(secondary: secondarySwatch),
          backgroundColor: primarySwatch,
          scaffoldBackgroundColor: primarySwatch,
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: primarySwatch,
                size: 24,
              ),
          primaryIconTheme: IconThemeData(
            color: primarySwatch,
            size: 40,
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: secondarySwatch,
                displayColor: secondarySwatch,
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: secondarySwatch,
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: primarySwatch,
                  size: 40,
                ),
            titleTextStyle: TextStyle(
              color: primarySwatch[500],
              fontSize: 40,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: secondarySwatch[500]),
            hintStyle: TextStyle(color: secondarySwatch[500]),
          )),
      home: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: AppBar(
            title: const Text('What To Do?'),
          ),
          body: const ToDoList(),
          drawer: const Text('Hello from Drawer'),
          floatingActionButton: Builder(
            builder: (context) {
              final ThemeData theme = Theme.of(context);
              return FloatingActionButton(
                child: Icon(
                  Icons.add,
                  size: theme.primaryIconTheme.size,
                  color: theme.primaryIconTheme.color,
                ),
                elevation: 10,
                // onPressed: () => Scaffold.of(context).openDrawer(),
                onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return AddItem();
                    }),
              );
            },
          ),
        );
      }),
    );
  }
}

// class ToDoHomePage extends StatefulWidget {
//   const ToDoHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<ToDoHomePage> createState() => _ToDoHomePageState();
// }

// class _ToDoHomePageState extends State<ToDoHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
