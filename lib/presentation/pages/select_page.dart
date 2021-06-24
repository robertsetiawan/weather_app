import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bussiness_logic/bloc/city_bloc.dart';
import 'package:weather_app/bussiness_logic/bloc/location_bloc.dart';
import 'package:weather_app/presentation/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectPage extends StatefulWidget {
  final String title;

  final String selectedCountry;

  const SelectPage(
      {Key? key, required this.title, required this.selectedCountry})
      : super(key: key);
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  TextEditingController selectController = new TextEditingController();

  late LocationBloc locationBloc;

  late CityBloc cityBloc;

  List<String> searchResult = [];

  List<String> sourceList = [];

  @override
  void dispose() {
    super.dispose();
    selectController.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.selectedCountry == "") {
      locationBloc = BlocProvider.of<LocationBloc>(context);

      locationBloc.add(LocationLoadCountry());
    } else {
      cityBloc = BlocProvider.of<CityBloc>(context);

      cityBloc.add(LocationLoadCity(widget.selectedCountry));
    }
  }

  Future<void> searchOperation(String searchText) async {
    if (searchResult.isNotEmpty) {
      setState(() {
        searchResult.clear();
      });
    }

    for (int i = 0; i < sourceList.length; i++) {
      String data = sourceList[i];
      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        setState(() {
          searchResult.add(data);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultAppbar('Select ' + widget.title),
        body: Padding(
          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
          child: (widget.selectedCountry == "")
              ? BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state is LocationLoadedCountry) {
                      sourceList = state.countryList;
                      return Column(
                        children: [
                          TextField(
                            onChanged: searchOperation,
                            controller: selectController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a ' + widget.title + ' name',
                            ),
                          ),
                          (searchResult.length != 0 &&
                                  selectController.text.isNotEmpty)
                              ? buildQuery(searchResult)
                              : buildQuery(sourceList)
                        ],
                      );
                    } else if (state is LocationLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                )
              : BlocBuilder<CityBloc, CityState>(
                  builder: (context, state) {
                    if (state is LocationLoadedCity) {
                      sourceList = state.cityList;
                      return Column(
                        children: [
                          TextField(
                            onChanged: searchOperation,
                            controller: selectController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a ' + widget.title + ' name',
                            ),
                          ),
                          (searchResult.length != 0 &&
                                  selectController.text.isNotEmpty)
                              ? buildQuery(searchResult)
                              : buildQuery(sourceList)
                        ],
                      );
                    } else if (state is CityLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                ),
        ),
      ),
    );
  }

  Widget buildQuery(List<String> location) {
    String selectedLocation;

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: ListView.builder(
          itemCount: location.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            child: ListTile(
              onTap: () {
                selectedLocation = location[index];
                Navigator.pop(context, selectedLocation);

                if (widget.selectedCountry == "") {
                  locationBloc.add(LocationSelectCountry(selectedLocation));
                } else {
                  cityBloc.add(LocationSelectCity(selectedLocation));
                }
              },
              title: Text(
                location[index].toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
