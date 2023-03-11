import 'package:flutter/material.dart';
import 'countries_stats_screen.dart';

class CountryDetails extends StatelessWidget {
  CountryDetails(
      {super.key,
      required this.image,
      required this.name,
      required this.todayRecovered,
      required this.totalCases,
      required this.active,
      required this.critical,
      required this.test,
      required this.totalDeaths,
      required this.totalRecovered});

  String image,
      name,
      totalCases,
      totalRecovered,
      totalDeaths,
      active,
      test,
      todayRecovered,
      critical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(name),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        ReusableRow(
                          title: 'Cases',
                          value: totalCases.toString(),
                        ),
                        ReusableRow(
                          title: 'Recovered',
                          value: totalRecovered.toString(),
                        ),
                        ReusableRow(
                          title: 'Death',
                          value: totalDeaths.toString(),
                        ),
                        ReusableRow(
                          title: 'Critical',
                          value: critical.toString(),
                        ),
                        ReusableRow(
                          title: 'Today Recovered',
                          value: totalRecovered.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(image),
                ),
                // Container(height: 50, width: 50, color: Colors.white,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
