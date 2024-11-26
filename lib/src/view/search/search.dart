import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/core.dart';
import 'package:weather_app/src/cubit/network_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage._();

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const SearchPage._());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus =
        context.watch<NetworkCubit>().state == NetworkStatus.connected;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: Text(
            'Search',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          )),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              TextFormField(
                controller: _textController,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  if (networkStatus) {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop(value.trim());
                    }
                  } else {
                    UserNotification.showSnackBar(
                        "Please check you internet connection.");
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'City',
                    border: const OutlineInputBorder(),
                    hintText: 'Type your city name',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black54),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        if (networkStatus) {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pop(_text.trim());
                          }
                        } else {
                          FocusScope.of(context).unfocus();
                          UserNotification.showSnackBar(
                              "Please check you internet connection.");
                        }
                      },
                    )),
              ),
              const Spacer(),
              Text(
                '🗺️',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 100),
              ),
              Text(
                'Find weather for your city',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
