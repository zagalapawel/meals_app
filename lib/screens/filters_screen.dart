import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    bool currentValue,
    String title,
    String description,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Filters'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            final selectedFilters = {
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegetarian': _vegetarian,
              'vegan': _vegan,
            };
            widget.saveFilters(selectedFilters);
          },
        ),
      ]),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchListTile(
                _glutenFree,
                'Gluten-free',
                'Only include gluten-free meals.',
                (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                _vegetarian,
                'Vegetarian',
                'Only include vegetarian meals.',
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                _vegan,
                'Vegan',
                'Only include vegan meals.',
                (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                _lactoseFree,
                'Lactose-free',
                'Only include lactose-free meals.',
                (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
