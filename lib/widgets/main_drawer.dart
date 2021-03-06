import 'package:flutter/material.dart';
import '../screens/tabs_screen.dart';
import '../providers/language_provider.dart';
import 'package:provider/provider.dart';
import '../screens/themes_screen.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      String title, IconData icon, Function tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(ctx).textTheme.bodyText1.color,
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                alignment:
                    lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
                color: Theme.of(context).accentColor,
                child: Text(
                  lan.getTexts("drawer_name"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme.of(context).accentColor.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildListTile(lan.getTexts('drawer_item1'), Icons.restaurant, () {
                Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
              }, context),
              buildListTile(lan.getTexts('drawer_item2'), Icons.settings, () {
                Navigator.of(context)
                    .pushReplacementNamed(FiltersScreen.routeName);
              }, context),
              buildListTile(lan.getTexts('drawer_item3'), Icons.color_lens, () {
                Navigator.of(context)
                    .pushReplacementNamed(ThemesScreen.routeName);
              }, context),
              Divider(height: 10, color: Colors.black54),
              Container(
                alignment: lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
                padding: EdgeInsets.only(left:20, top: 20, right: 22),
                child: Text(
                  lan.getTexts('drawer_switch_title'),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: lan.isEn ? 0 : 20,
                    left: lan.isEn ? 20 : 0,
                    bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(lan.getTexts('drawer_switch_item2'),
                        style: Theme.of(context).textTheme.headline6),
                    Switch(
                      value: Provider.of<LanguageProvider>(context, listen: true)
                          .isEn,
                      onChanged: (newValue) {
                        Provider.of<LanguageProvider>(context, listen: false)
                            .changeLan(newValue);
                        Navigator.of(context).pop();
                      },
                      inactiveTrackColor:
                          Theme.of(context).accentColor.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.grey,
                    ),
                    Text(lan.getTexts('drawer_switch_item1'),
                        style: Theme.of(context).textTheme.headline6),
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
