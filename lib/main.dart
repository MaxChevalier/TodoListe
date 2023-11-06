import 'package:flutter/material.dart';
import 'page/todoList.dart';
import 'page/createTodo.dart';
import 'page/error/404.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TodoList',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color.fromARGB(255, 195, 67, 221),
            secondary: Color.fromARGB(255, 198, 37, 204),
          ),
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
        ),
        initialRoute: '/',
        home: TodoList(),
        onGenerateRoute: (settings) {
          // Si la route n'est pas trouvée dans la map des routes.
          if (settings.name == '/createTodo') {
            return PageRouteBuilder(
                pageBuilder: (_, __, ___) => AddTodo(),
                transitionDuration: Duration(seconds: 1),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(begin: begin, end: end);
                  final curvedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: curve,
                  );

                  return SlideTransition(
                    position: tween.animate(curvedAnimation),
                    child: child,
                  );
                });
            // return MaterialPageRoute(builder: (context) => NotFoundPage());
          }
          return PageRouteBuilder(
              pageBuilder: (_, __, ___) => NotFoundPage(),
              transitionDuration: Duration(seconds: 2),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: curve,
                );

                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: child,
                );
              });
        });
  }
}
