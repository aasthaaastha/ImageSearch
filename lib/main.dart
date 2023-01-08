import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:task/widgets/reusabel_widgets.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List photos = [];
  var searchPhotos;
  var data;
  Set<String> categories = {'ALL'};
  int initPosition = 0;
  var temp;
  bool search = false;

  Future<void> getImages() async {
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/7451386e-f8a3-4279-94fb-9a06deef96cf'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      // print(data);
      setState(() {
        photos = data['data'];
      });
      print(photos);
      for (int i = 0; i < photos.length; i++) {
        categories.add(photos[i]['category']);
      }
      print(data);
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    getImages();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      // color: Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchController,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Search',
                              prefix: InkWell(
                                  onTap: () {
                                    searchController.clear();
                                    setState(() {
                                      search = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color: search == true
                                        ? Colors.blue
                                        : Colors.white,
                                  )),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          searchPhotos = photos
                              .where((photos) =>
                                  (photos["category"] == searchController.text))
                              .toList();
                          print(searchPhotos);
                          setState(() {
                            search = true;
                          });
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              // SearchBarAnimation(
              //   onFieldSubmitted: () {
              //     // photos.clear();
              //     searchPhotos =
              //         photos.where((photos) => (photos["category"] == searchController.text));
              //     print(searchPhotos);
              //   },
              //   textEditingController: searchController,
              //   isOriginalAnimation: true,
              //   enableKeyboardFocus: true,
              //   onExpansionComplete: () {
              //     setState(() {
              //       search = true;
              //     });
              //     // photos.clear();
              //   },
              //   onCollapseComplete: () {
              //     setState(() {
              //       search = false;
              //     });
              //     debugPrint('do something just after searchbox is closed.');
              //   },
              //   onPressButton: (isSearchBarOpens) {
              //     isSearchBarOpens
              //         ? {
              //             setState(() {
              //               search = true;
              //             }),
              //             // photos.clear();
              //           }
              //         : setState(() {
              //             search = false;
              //           });
              //     debugPrint(
              //         'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
              //   },
              //   trailingWidget: const Icon(
              //     Icons.search,
              //     size: 20,
              //     color: Colors.black,
              //   ),
              //   secondaryButtonWidget: const Icon(
              //     Icons.close,
              //     size: 20,
              //     color: Colors.black,
              //   ),
              //   buttonWidget: const Icon(
              //     Icons.search,
              //     size: 20,
              //     color: Colors.black,
              //   ),
              // ),
              ),
          backgroundColor: Colors.white,
          body: search == true
              ? searchPhotos == null
                  ? SizedBox.shrink()
                  : GridView.builder(
                      itemCount: searchPhotos.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0),
                      itemBuilder: (BuildContextcontext, intindex) {
                        return Image(
                            fit: BoxFit.fitHeight,
                            image: NetworkImage(searchPhotos[intindex]['url']));
                      },
                    )
              : CustomTabView(
                  initPosition: initPosition,
                  itemCount: categories.length,
                  tabBuilder: (context, index) => Tab(
                    text: categories.elementAt(index),
                  ),
                  pageBuilder: (context, index) => GridView.builder(
                    itemCount: initPosition == 0 ? photos.length : temp.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContextcontext, intindex) {
                      return initPosition == 0
                          ? Image(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(photos[intindex]['url']))
                          : Image(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(temp[intindex]['url']));
                    },
                  ),
                  onPositionChange: (index) {
                    var temp = photos.where((photos) =>
                        (photos["category"] == categories.elementAt(index)));
                    print(temp);
                    // photos.clear();
                    setState(() {
                      this.temp = temp.toList();
                    });

                    initPosition = index;
                  },
                  // onScroll: (position) => print('$position'),
                ),
        ),
      ),
    );
  }
}
