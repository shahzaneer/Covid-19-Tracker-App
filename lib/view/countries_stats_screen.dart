// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:covid_app/Models/world_stats_%20model.dart';
import 'package:covid_app/view/countried_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Services/app_services.dart';

class CountriesStatesScreen extends StatefulWidget {
  const CountriesStatesScreen({super.key});

  @override
  State<CountriesStatesScreen> createState() => _CountriesStatesScreenState();
}

class _CountriesStatesScreenState extends State<CountriesStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("I am here");
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                FutureBuilder(
                  future: AppServices.fetchWorldStats(),
                  builder: (BuildContext context,
                      AsyncSnapshot<world_stats_model> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitCircle(
                          controller: _controller,
                          color: Colors.grey,
                          size: 50,
                          duration: const Duration(milliseconds: 1200),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": snapshot.data!.cases!.toDouble(),
                              "Recovered": snapshot.data!.recovered!.toDouble(),
                              "Deaths": snapshot.data!.deaths!.toDouble()
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesOutside: true,
                              decimalPlaces: 1,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: const [
                              Colors.blue,
                              Colors.green,
                              Colors.red
                            ],
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 5, left: 10, right: 10),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        value: "Total",
                                        title: snapshot.data!.cases.toString()),
                                    ReusableRow(
                                        value: "Critical",
                                        title:
                                            snapshot.data!.critical.toString()),
                                    ReusableRow(
                                        value: "Deaths",
                                        title:
                                            snapshot.data!.deaths.toString()),
                                    ReusableRow(
                                        value: "Active",
                                        title:
                                            snapshot.data!.active.toString()),
                                    ReusableRow(
                                        value: "Polulation",
                                        title: snapshot.data!.population
                                            .toString()),
                                    ReusableRow(
                                        value: "Tests",
                                        title: snapshot.data!.tests.toString()),
                                    ReusableRow(
                                        value: "Todays Cases",
                                        title: snapshot.data!.todayCases
                                            .toString()),
                                    ReusableRow(
                                        value: "Updated",
                                        title:
                                            snapshot.data!.updated.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CountriesListScreen()));
                            },
                            child: Ink(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(child: Text("Track Countries", textAlign: TextAlign.center,)),
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0 ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(value), Text(title)],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider()
      ],
    );
  }
}
