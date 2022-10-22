import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = '';
  List content = [];
  int? selectedId;
  final textController = TextEditingController();

  String client_id = 'q06uP1ZqopkDJZuahHwQ';
  String client_secret = 'ipr1csrtAj';

  @override
  void initState() {
    super.initState();
  }

  void test() async {
    http.Response response = await http.get(
        Uri.parse(
            "https://openapi.naver.com/v1/search/image?query=${title}&display=100&sort=sim"),
        headers: <String, String>{
          'X-Naver-Client-Id': client_id,
          'X-Naver-Client-Secret': client_secret
        });
    var resBody = jsonDecode(utf8.decode(response.bodyBytes));
    content = resBody['items'];
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 180,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          flexibleSpace: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF162465),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'for ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'everything',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: size.width - 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  test();
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.pinkAccent,
                                  size: 28,
                                )),
                            new Flexible(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) {
                                  test();
                                },
                                textAlign: TextAlign.left,
                                onChanged: (value) {
                                  title = value;
                                },
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFD1D9E6),
                                  ),
                                  labelStyle:
                                      TextStyle(color: Color(0xff878E97)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyImagePage()));
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.pinkAccent,
                              size: 24,
                            )),
                      ),
                    ],
                  ),
                ],
              )),
        ),
        body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search result',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF162465),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 14,),
                    Theme(
                      data: ThemeData(
                        primarySwatch: Colors.blue,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: content.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: size.width - 144,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(imageUrl: '${content[index]['link']}',)));
                              },
                              child: Image(
                                image: CachedNetworkImageProvider('${content[index]['link']}'),
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    'assets/error-image-generic.png',
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      )
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}


class Grocery {
  final int? id;
  final String name;

  Grocery({this.id, required this.name});

  factory Grocery.fromMap(Map<String, dynamic> json) => new Grocery(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'groceries.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE groceries(
      id INTEGER PRIMARY KEY,
      name TEXT
    )
    ''');
  }

  Future<int> add(Grocery grocery) async {
    Database db = await instance.database;
    return await db.insert('groceries', grocery.toMap());
  }

  Future<List<Grocery>> getGroceries() async {
    Database db = await instance.database;
    var groceries = await db.query('groceries', orderBy: 'name');
    List<Grocery> groceryList = groceries.isNotEmpty
        ? groceries.map((c) => Grocery.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<int> update(Grocery grocery) async {
    Database db = await instance.database;
    return await db.update('groceries', grocery.toMap(),
        where: 'id = ?', whereArgs: [grocery.id]);
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('groceries', where: 'id = ?', whereArgs: [id]);
  }
}


class MyImagePage extends StatefulWidget {
  MyImagePage({Key? key}) : super(key: key);

  @override
  _MyImagePageState createState() => _MyImagePageState();
}

class _MyImagePageState extends State<MyImagePage> {
  int? selectedId;
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF162465),
        title: Text('나의 즐겨찾기'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Grocery>>(
          future: DatabaseHelper.instance.getGroceries(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Grocery>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Loading'),
              );
            }
            return snapshot.data!.isEmpty
                ? Center(child: Text('선택하신 즐겨찾기가 없습니다!'))
                : ListView(
              children: snapshot.data!.map((grocery) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image(
                        image: CachedNetworkImageProvider('${grocery.name}'),
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context,
                            Object exception, StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/error-image-generic.png',
                          );
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}


class DetailPage extends StatefulWidget {
  String imageUrl;

  DetailPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF162465),
        title: Text('자세히 보기'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image(
                  image: CachedNetworkImageProvider('${widget.imageUrl}'),
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context,
                      Object exception, StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/error-image-generic.png',
                    );
                  },
                ),
              ),
              SizedBox(height: 60,),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF162465),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () async {
                    if(check == false) {
                      check = true;
                      await DatabaseHelper.instance.add(
                        Grocery(name: widget.imageUrl),
                      );
                      setState(() {

                      });
                    }
                  },
                  icon: check ? Icon(
                    Icons.favorite,
                    color: Colors.pinkAccent,
                    size: 24,
                  ) : Icon(
                    Icons.favorite_border,
                    color: Colors.pinkAccent,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}