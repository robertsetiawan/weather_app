import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bussiness_logic/bloc/city_bloc.dart';
import 'package:weather_app/bussiness_logic/bloc/connection_bloc.dart';
import 'package:weather_app/bussiness_logic/bloc/location_bloc.dart';
import 'package:weather_app/presentation/pages/result_page.dart';
import 'package:weather_app/presentation/pages/select_page.dart';
import 'package:weather_app/presentation/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String selectedCountry;

  late String selectedCity;

  Future<String> navigateToSelectPage(
      String title, String selectedCountry) async {
    String selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectPage(
          title: title,
          selectedCountry: selectedCountry,
        ),
      ),
    );
    return selectedLocation;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: defaultAppbar("Simple Weather Demo"),
        body: SingleChildScrollView(
          child: BlocListener<ConnectionBloc, ConnectionAppState>(
            listener: (context, state) {
              if (!state.isConnected) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("No Connection"),
                    duration: Duration(days: 1)));
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                CachedNetworkImage(
                  width: 150,
                  height: 150,
                  imageUrl:
                      "https://png.pngtree.com/png-vector/20190629/ourmid/pngtree-sun-icon-design-png-image_1518941.jpg",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Transform.scale(
                    scale: 0.5,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      BlocProvider.of<LocationBloc>(context)
                          .add(LocationClearCountry());
                      BlocProvider.of<CityBloc>(context)
                          .add(LocationClearCity());

                      selectedCity = "";
                      selectedCountry = "";

                      selectedCountry =
                          await navigateToSelectPage('country', "");
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, state) {
                          if (state is LocationSelectedCountry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.selectedCountry,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            );
                          }
                          selectedCountry = "";
                          return Text("Click to select country");
                        },
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (selectedCountry != "")
                        selectedCity =
                            await navigateToSelectPage('city', selectedCountry);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue)),
                      child: BlocBuilder<CityBloc, CityState>(
                        builder: (context, state) {
                          if (state is LocationSelectedCity) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.selectedCity,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            );
                          }
                          selectedCity = "";
                          return Text("Click to select city");
                        },
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: OutlinedButton(
                      onPressed: () {
                        if (selectedCity != "") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ResultPage(city: selectedCity),
                            ),
                          );

                          BlocProvider.of<LocationBloc>(context)
                              .add(LocationClearCountry());
                          BlocProvider.of<CityBloc>(context)
                              .add(LocationClearCity());
                        }
                      },
                      child: Text("Search Location"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
