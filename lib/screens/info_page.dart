import 'package:flutter/material.dart';
import 'package:brands_info_app/screens/data.dart';
import 'dart:math';

class InfoPage extends StatelessWidget {
  InfoPage({Key? key, this.brand}) : super(key: key);

  final Map<String, String>? brand;
  final List<int> recomendations = [];
  final Set<int> temp = {};

  void recomendationsGenerator() {
    while (temp.length != 7) {
      temp.add(Random().nextInt(brands.length));
    }
    for (var i in temp) {
      recomendations.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    recomendationsGenerator();
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          appBar(context),
          body(context),
        ],
      ),
    );
  }

  SliverAppBar appBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      backgroundColor: const Color(0xFF303030),
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeInImage(
          fit: BoxFit.cover,
          placeholder: const AssetImage("./assets/loader.gif"),
          image: NetworkImage(
            brand!["image"].toString(),
          ),
        ),
      ),
    );
  }

  SliverPadding body(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                text(context, "name", 0.1, FontWeight.bold),
                text(context, "income", 0.06, FontWeight.w700),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            text(context, "date", 0.06, FontWeight.w700),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            text(context, "description", 0.045, FontWeight.w500),
            Divider(
              height: MediaQuery.of(context).size.height * 0.04,
              thickness: 1.5,
            ),
            text(context, "info", 0.04, FontWeight.w400),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              "Recomendations:",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF303030),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.network(
                              brands[recomendations[index]]["logo"].toString(),
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            brands[recomendations[index]]["name"].toString(),
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => InfoPage(
                          brand: brands[recomendations[index]],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text text(BuildContext context, String data, double textSize,
      FontWeight textWeight) {
    return Text(
      brand![data].toString(),
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * textSize,
        fontWeight: textWeight,
      ),
    );
  }
}
