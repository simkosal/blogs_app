// import 'dart:async';

// import 'package:app_links/app_links.dart';
// import 'package:blogs_app/src/models/blogs_data.dart';
// import 'package:blogs_app/src/screens/home_detail.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // Parse the deep link URL to extract the productID
//   String? getProductID(String? link) {
//     if (link == null || link.isEmpty) return null;

//     final uri = Uri.tryParse(link);

//     // If the URL has properly formatted query parameters
//     if (uri != null && uri.queryParameters.containsKey('productID')) {
//       return uri.queryParameters['productID'];
//     }

//     // Handle cases where productID appears in the path (e.g., "/productID=10")
//     final regex =
//         RegExp(r'productID=([^&/]+)'); // Match 'productID=' followed by value
//     final match = regex.firstMatch(link);
//     return match?.group(1); // Return the matched value
//   }

//   @override
//   void dispose() {
//     _linkSubscription?.cancel();

//     super.dispose();
//   }

//   late AppLinks _appLinks;
//   StreamSubscription<Uri>? _linkSubscription;

//   Future<void> initDeepLinks() async {
//     _appLinks = AppLinks();

//     // Handle links
//     _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
//       debugPrint('onAppLink: $uri');
//       debugPrint(uri.path);
//       route(pID: uri.path);
//       message(uri.host);
//     });
//   }

//   // // Initialize deep link listener
//   // Future<void> _initDeepLink() async {
//   //   try {
//   //     // Check for incoming deep links
//   //     final initialLink = await getInitialLink();
//   //     if (initialLink != null) {
//   //       String? pID = getProductID(initialLink);
//   //       route(pID: pID);
//   //     }

//   //     // Listen for incoming deep links while the app is in the foreground
//   //     linkStream.listen((String? link) {
//   //       if (link != null) {
//   //         String? pID = getProductID(link);
//   //         route(pID: pID);
//   //       }
//   //     });
//   //   } catch (e) {
//   //     debugPrint('Error occurred while handling deep link: $e');
//   //   }
//   // }

//   void route({String? pID = "0"}) {
//     try {
//       Map<String, String> element =
//           blogs.firstWhere((element) => element['pID'] == pID);

//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (ctx) => HomeDetail(
//                 data: element,
//               )));
//     } catch (e) {
//       message('Not found: ($pID)');
//     }
//   }

//   void message(String? msg) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(msg ?? 'Untitled')));
//   }

//   @override
//   void initState() {
//     // _initDeepLink();
//     initDeepLinks();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).textTheme;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text('Home',
//             style: theme.headlineSmall?.copyWith(color: Colors.white)),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Determine the layout based on the screen width
//           if (constraints.maxWidth > 600) {
//             return Center(
//               child: Container(
//                 alignment: Alignment.center,
//                 width: 900,
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 4.0,
//                     crossAxisSpacing: 4.0,
//                   ),
//                   padding: const EdgeInsets.all(16.0),
//                   itemCount: blogs.length,
//                   itemBuilder: (context, index) {
//                     return PostCard(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (ctx) =>
//                                   HomeDetail(data: blogs[index])));
//                         },
//                         imagePath: blogs[index]['path']!,
//                         category: blogs[index]['category']!,
//                         date: blogs[index]['date']!,
//                         title: blogs[index]['title']!,
//                         description: blogs[index]['shortDescription']!);
//                   },
//                 ),
//               ),
//             );
//           } else {
//             // Mobile layout: Single-column list
//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: blogs.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: IntrinsicHeight(
//                     child: PostCard(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (ctx) => HomeDetail(data: blogs[index])));
//                       },
//                       imagePath: blogs[index]['path']!,
//                       category: blogs[index]['category']!,
//                       date: blogs[index]['date']!,
//                       title: blogs[index]['title']!,
//                       description: blogs[index]['shortDescription']!,
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class PostCard extends StatelessWidget {
//   final String imagePath;
//   final String category;
//   final String date;
//   final String title;
//   final String description;

//   final Function()? onPressed;

//   const PostCard(
//       {super.key,
//       required this.imagePath,
//       required this.category,
//       required this.date,
//       required this.title,
//       required this.description,
//       this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Card(
//         color: const Color(0xFF2C2C2C),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration:
//                         BoxDecoration(borderRadius: BorderRadius.circular(12)),
//                     width: double.infinity,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(imagePath)),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Category and Date Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CategoryBadge(text: category),
//                     DateBadge(text: date),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 // Title and Description
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   description,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.white70,
//                   ),
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 16),
//                 // Download Button
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: onPressed,
//                   child: const Center(
//                     child: Text(
//                       'Read More',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CategoryBadge extends StatelessWidget {
//   final String text;

//   const CategoryBadge({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Text(
//         text.toUpperCase(),
//         style: const TextStyle(
//             color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// class DateBadge extends StatelessWidget {
//   final String text;

//   const DateBadge({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(color: Colors.white54),
//       ),
//       child: Text(
//         text.toUpperCase(),
//         style: const TextStyle(
//             color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    final productId = uri.queryParameters['productID'];
    if (productId != null) {
      _navigatorKey.currentState?.pushNamed('/productID/$productId');
    } else {
      _navigatorKey.currentState?.pushNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        Widget routeWidget = defaultScreen();

        final routeName = settings.name;
        if (routeName != null) {
          if (routeName.startsWith('/productID/')) {
            final productId = routeName.replaceFirst('/productID/', '');
            routeWidget = customScreen(productId);
          }
        }

        return MaterialPageRoute(
          builder: (context) => routeWidget,
          settings: settings,
        );
      },
    );
  }

  Widget defaultScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text('Default Screen')),
      body: const Center(child: Text('Default home screen')),
    );
  }

  Widget customScreen(String bookId) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(child: Text('Opened with parameter: $bookId')),
    );
  }
}