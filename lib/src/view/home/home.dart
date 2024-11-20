import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Map<String, dynamic>> locations = [
    {
      "name": "Edappal",
      "lat": 10.7676,
      "long": 75.9983,
    },
    {
      "name": "Edappally",
      "lat": 10.0159,
      "long": 76.3070,
    },
    {
      "name": "Kochin",
      "lat": 9.9312,
      "long": 76.2673,
    },
    {
      "name": "Thrissur",
      "lat": 10.5276,
      "long": 76.2144,
    },
    {
      "name": "Kollam",
      "lat": 8.8932,
      "long": 76.6141,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (_, i) {
            var location = locations[i];
            return ListTile(
              onTap: () async {},
              enableFeedback: true,
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(.6),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.location_city,
                  )),
              title: Text(
                location['name'],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            );
          }),
    );
  }
}
