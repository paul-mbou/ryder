import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ryde_app/src/core/constants/assets/assets.gen.dart';
import 'package:ryde_app/src/core/theme/pallete.dart';
import 'package:ryde_app/src/core/utils/extensions.dart';
import 'package:ryde_app/src/features/auth/ui/auth_provider.dart';
import 'package:ryde_app/src/widgets/app_default_spacing.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final WebViewController _controller;
  final String url =
      "https://api.maptiler.com/maps/019d4a17-afb7-7a4e-9d09-7a9c9d088862/?key=pc5ACttwFf4zsrCCEV69#14.3/4.05565/9.72271";
  // Style? _mapStyle;
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    // _loadMapStyle();
  }

  // Future<void> _loadMapStyle() async {
  //   final style = await StyleReader(
  //     uri:
  //         'https://api.maptiler.com/maps/019d4a17-afb7-7a4e-9d09-7a9c9d088862/style.json?key=pc5ACttwFf4zsrCCEV69',
  //   ).read();
  //   setState(() => _mapStyle = style);
  // }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FA),
      body: AppDefaultSpacing(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome User',
                  style: context.text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                IconButton.outlined(
                  iconSize: 32,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.white),
                  ),
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                  },
                  icon: Assets.icons.logout.svg(),
                ),
              ],
            ),
            Gutter(),
            FormBuilderTextField(
              name: "name",
              decoration: InputDecoration().copyWith(
                hintText: 'Where do you want to go?',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Assets.icons.search.svg(),
                ),
                border: context.theme.inputDecorationTheme.border?.copyWith(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: context.theme.inputDecorationTheme.enabledBorder
                    ?.copyWith(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                fillColor: Colors.white,
              ),
            ),

            GutterLarge(),
            Text(
              'Your current location',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Gutter(),
            SizedBox(
              height: 400,
              child: WebViewWidget(controller: _controller),

              // FlutterMap(
              //   children: [
              //     if (_mapStyle != null)
              //       VectorTileLayer(
              //         tileOffset: TileOffset(zoomOffset: 0),
              //         // tileProviders: _mapStyle!.providers,
              //         tileProviders: TileProviders({
              //           'maptiler_planet_v4': NetworkVectorTileProvider(
              //             urlTemplate:
              //                 'https://api.maptiler.com/maps/019d4a17-afb7-7a4e-9d09-7a9c9d088862/256/{z}/{x}/{y}.pbf?key=pc5ACttwFf4zsrCCEV69',
              //           ),
              //         }),
              //         theme: _mapStyle!.theme,
              //       ),
              //   ],
              // ),
            ),
            GutterLarge(),
            Text(
              'Recent Rides',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(children: [Row(children: [ ],)]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Pallete.active,
        unselectedItemColor: Pallete.hintColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
