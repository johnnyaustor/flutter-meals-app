import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Map<String, bool> filters;
  final Function saveHandler;
  const FiltersScreen(this.filters, this.saveHandler, {Key? key})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  initState() {
    _glutenFree = widget.filters['gluten']!;
    _lactoseFree = widget.filters['lactose']!;
    _vegan = widget.filters['vegan']!;
    _vegetarian = widget.filters['vegetarian']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool value, Function handler) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (val) => handler(val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final selectedFilter = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveHandler(selectedFilter);
            },
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten Free',
                  'Only include gluten free meals',
                  _glutenFree,
                  (val) {
                    setState(() {
                      _glutenFree = val;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose Free',
                  'Only include lactose free meals',
                  _lactoseFree,
                  (val) {
                    setState(() {
                      _lactoseFree = val;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian Free',
                  'Only include vegetarian free meals',
                  _vegetarian,
                  (val) {
                    setState(() {
                      _vegetarian = val;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegan Free',
                  'Only include vegan free meals',
                  _vegan,
                  (val) {
                    setState(() {
                      _vegan = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
