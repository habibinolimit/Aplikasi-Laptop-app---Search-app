  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'model.dart';
  import 'service.dart';

  void main() => runApp(MyApp());

  class MyApp extends StatefulWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    State<MyApp> createState() => _MyAppState();
  }

  class _MyAppState extends State<MyApp> {
    late List<stok> laptops;
    late List<stok> filteredLaptops;

    @override
    void initState() {
      super.initState();
      laptops = [];
      filteredLaptops = [];
      fetchLaptop(http.Client()).then((data) {
        setState(() {
          laptops = data;
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'My Laptop App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: Icon(Icons.laptop),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.white],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        filteredLaptops = filterLaptops(value);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Enter laptop model...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: LaptopList(
                    Laptoplist: filteredLaptops.isNotEmpty
                        ? filteredLaptops
                        : laptops,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    List<stok> filterLaptops(String query) {
      return laptops.where((laptop) {
        final modelLower = laptop.model.toLowerCase();
        final queryLower = query.toLowerCase();
        return modelLower.contains(queryLower);
      }).toList();
    }
  }

  class LaptopList extends StatelessWidget {
    final List<stok> Laptoplist;

    LaptopList({Key? key, required this.Laptoplist}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: Laptoplist.length,
        itemBuilder: (_, index) {
          var data = Laptoplist[index];
          return Card(
            elevation: 8.0,
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blueAccent, Colors.blue],
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text(
                  data.model,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  '${data.brand} - ${data.production_year}',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(data: data),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }

  class DetailScreen extends StatelessWidget {
    final stok data;

    DetailScreen({required this.data});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Product Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.white],
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Model: ${data.model}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(height: 16.0),
                      Text('Brand: ${data.brand}', style: TextStyle(fontSize: 18, color: Colors.black)),
                      Text('Production Year: ${data.production_year.toString()}',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      Text('Price: \$${data.price.toString()}',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'http://10.0.2.2/dbpm_api/${data.Gambar}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }