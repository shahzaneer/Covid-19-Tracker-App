import 'package:covid_app/Services/app_services.dart';
import 'package:covid_app/view/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.1,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Search with Names",
                  suffixIcon: _controller.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            _controller.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.clear)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: AppServices.fetchCountriesStats(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  width: 100,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (_controller.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetails(
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'],
                                        totalCases: snapshot.data![index]
                                                ['cases']
                                            .toString(),
                                        totalRecovered: snapshot.data![index]
                                                ['recovered']
                                            .toString(),
                                        totalDeaths: snapshot.data![index]
                                                ['deaths']
                                            .toString(),
                                        active: snapshot.data![index]['active']
                                            .toString(),
                                        test: snapshot.data![index]['tests']
                                            .toString(),
                                        todayRecovered: snapshot.data![index]
                                                ['todayRecovered']
                                            .toString(),
                                        critical: snapshot.data![index]
                                                ['critical']
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      "Effected: ${snapshot.data![index]['cases']}"),
                                ),
                              ),
                              const Divider()
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(_controller.text.toLowerCase())) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetails(
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'],
                                        totalCases: snapshot.data![index]
                                                ['cases']
                                            .toString(),
                                        totalRecovered: snapshot.data![index]
                                                ['recovered']
                                            .toString(),
                                        totalDeaths: snapshot.data![index]
                                                ['deaths']
                                            .toString(),
                                        active: snapshot.data![index]['active']
                                            .toString(),
                                        test: snapshot.data![index]['tests']
                                            .toString(),
                                        todayRecovered: snapshot.data![index]
                                                ['todayRecovered']
                                            .toString(),
                                        critical: snapshot.data![index]
                                                ['critical']
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      "Effected: ${snapshot.data![index]['cases']}"),
                                ),
                              ),
                              const Divider()
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
