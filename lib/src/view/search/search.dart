import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: Text(
            'City Search',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          )),
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
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(value.trim());
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
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
                      icon: const Icon(Icons.search, semanticLabel: 'Submit'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop(_text.trim());
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
                'Find Your Desired Location',
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
