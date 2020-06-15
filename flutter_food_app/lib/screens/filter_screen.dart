  import 'package:flutter/material.dart';
  import '../widgets//main_drawer.dart';


  class FiltersScreen extends StatefulWidget {
    static const routeName ='/filters';
    final Function saveFilters;
    final Map<String ,bool> currentFilter;

    FiltersScreen(this.currentFilter,this.saveFilters);

    @override
    _FiltersScreenState createState() => _FiltersScreenState();
  }

  class _FiltersScreenState extends State<FiltersScreen> {
    bool _glutenFree = false;
    bool _vegetarian = false;
    bool _vegan = false;
    bool _lactoseFree = false;

    @override
    initState() {
      _glutenFree = widget.currentFilter['gluten'];
      _lactoseFree = widget.currentFilter['lactose'];
      _vegan = widget.currentFilter['vegan'];
      _vegetarian = widget.currentFilter['vegetarian'];
      super.initState();

    }

    Widget _buildSwitchTile(String title, String description,bool currentValue, Function updateValue){
      return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(
            description
        ),
        onChanged: updateValue ,
      );
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Your Filters'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.save), onPressed: () {
                final selectedfilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan
                };

                widget.saveFilters(selectedfilters); } )
            ],
          ),
          drawer: MainDrawer(),
          body: Column(
          children: <Widget>[
            Container(padding: EdgeInsets.all(20),child: Text('Adjust your meal selection.',style: Theme.of(context).textTheme.title,
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildSwitchTile('Gluten-free','Only gluten-free meals',_glutenFree,(newValue) {
                      setState(
                      () {
                          _glutenFree =newValue;
                      },);
                    },),
                  _buildSwitchTile('Lactose-free','Only lactose-free meals',_lactoseFree,(newValue) {
                      setState(
                      () {
                      _lactoseFree =newValue;
                      },);
                      },),
                  _buildSwitchTile('Vegetarian','Only Vegetarian meals',_vegetarian,(newValue) {
                      setState(
                      () {
                      _vegetarian =newValue;
                      },);
                      },),
                  _buildSwitchTile('Vegan','Only Vegan meals',_vegan,(newValue) {
                      setState(
                      () {
                      _vegan =newValue;
                      },);
                      },)
      ],),
      ),
      ],),
      );
     }
    }
