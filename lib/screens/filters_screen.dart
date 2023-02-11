import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentfilters;

  FilterScreen(this.currentfilters, this.saveFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactoseFree = false;

  @override
  void initState() {
    glutenFree = widget.currentfilters['gluten'];
    lactoseFree = widget.currentfilters['lactose'];
    vegetarian = widget.currentfilters['vegetarian'];
    vegan = widget.currentfilters['vegan'];
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedfilters = {
                  "gluten": glutenFree,
                  "lactose": lactoseFree,
                  "vegan": vegan,
                  "vegetarian": vegetarian,
                };
                widget.saveFilters(selectedfilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                    "Gluten-Free", "Only include gluten-free meal.", glutenFree,
                    (newValue) {
                  setState(() {
                    glutenFree = newValue;
                  });
                }),
                buildSwitchListTile(
                    "Vegetarian", "Only include veg meal.", vegetarian,
                    (newValue) {
                  setState(() {
                    vegetarian = newValue;
                  });
                }),
                buildSwitchListTile("Vegan", "Only include vegan meal.", vegan,
                    (newValue) {
                  setState(() {
                    vegan = newValue;
                  });
                }),
                buildSwitchListTile("Lactose-Free",
                    "Only include lactose-free meal.", lactoseFree, (newValue) {
                  setState(() {
                    lactoseFree = newValue;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
