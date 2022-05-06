import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_flutter/widgets/add_item.dart';
import 'package:to_do_flutter/widgets/to_do_list.dart';

import 'models/item.dart';

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

class App extends StatefulWidget {
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
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Item> _itemList = [
    Item(id: 1, title: 'Item 1', isCompleted: true),
    Item(id: 2, title: 'Item 2', isCompleted: false),
    Item(id: 3, title: 'Item 3', isCompleted: false),
  ];

  void addItem(List<Item> itemList) {
    setState(() {
      _itemList = [...itemList];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: widget.primarySwatch,
                primaryColorDark: widget.secondarySwatch)
            .copyWith(secondary: widget.secondarySwatch),
        backgroundColor: widget.primarySwatch,
        scaffoldBackgroundColor: widget.primarySwatch,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: widget.primarySwatch,
              size: 24,
            ),
        primaryIconTheme: IconThemeData(
          color: widget.primarySwatch,
          size: 40,
        ),
        textTheme: GoogleFonts.tekoTextTheme(
          Theme.of(context)
              .textTheme
              .copyWith(
                bodyMedium: const TextStyle(
                  fontSize: 24,
                ),
                titleMedium: const TextStyle(
                  fontSize: 24,
                ),
              )
              .apply(
                bodyColor: widget.secondarySwatch,
                displayColor: widget.secondarySwatch,
              ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: widget.secondarySwatch,
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: widget.primarySwatch,
                size: 40,
              ),
          titleTextStyle: TextStyle(
            color: widget.primarySwatch[500],
            fontSize: 40,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: widget.secondarySwatch[500]),
          hintStyle: TextStyle(color: widget.secondarySwatch[500]),
        ),
        dividerTheme: DividerThemeData(
          endIndent: 5,
          indent: 5,
          space: 15,
          thickness: 2,
          color: widget.secondarySwatch,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: widget.secondarySwatch,
            primary: widget.primarySwatch,
            minimumSize: const Size(88, 36),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
        ),
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: AppBar(
            title: const Text('What To Do?'),
          ),
          body: ToDoList(items: _itemList),
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
                    // shape: const RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.vertical(
                    //     top: Radius.circular(10),
                    //   ),
                    // ), // you can use shape on modal directly to give background shape
                    // you can also change bottomSheetTheme for bottomSheet style
                    builder: (context) {
                      return AddItem(onSubmit: addItem, itemList: _itemList);
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
