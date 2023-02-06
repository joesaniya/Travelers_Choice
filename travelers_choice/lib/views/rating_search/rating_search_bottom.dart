import 'package:flutter/material.dart';
import 'package:flutx/widgets/star_rating/star_rating.dart';

class RatingSearchDrawer extends StatefulWidget {
  const RatingSearchDrawer({Key? key}) : super(key: key);

  @override
  State<RatingSearchDrawer> createState() => _RatingSearchDrawerState();
}

class _RatingSearchDrawerState extends State<RatingSearchDrawer> {
  final List<bool?> _star = [false, true, true, true, true];

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: _star.length,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                _star[index] = _star[index];
              });
            },
            child: Row(
              children: <Widget>[
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: _star[index],
                  activeColor: theme.colorScheme.primary,
                  onChanged: (bool? value) {
                    setState(() {
                      _star[index] = value;
                    });
                  },
                ),
                Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: FxStarRating(
                        rating: (index + 1).toDouble(),
                        inactiveColor: theme.colorScheme.onBackground))
              ],
            ),
          );
        });
  }
}
