import 'package:flutter/material.dart';
import './info_page.dart';
import './data.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Brends",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: brands.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.06,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  brands[index]["logo"].toString(),
                ),
              ),
              title: Text(
                brands[index]["name"].toString(),
              ),
              subtitle: Text(
                brands[index]["date"].toString(),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => InfoPage(
                      brand: brands[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
