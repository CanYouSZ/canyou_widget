import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double defaultItemHeight = 50.0;
const EdgeInsetsGeometry defaultIconPadding = EdgeInsets.only(
  right: 15.0,
  top: 15.0,
  bottom: 15.0,
);

class ItemNormalWidget extends StatelessWidget {
  const ItemNormalWidget({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.contentPadding,
    this.onTap,
  })  : assert(title != null),
        super(key: key);

  final Widget? leading;

  final Widget title;

  final Widget? subtitle;

  final Widget? trailing;

  final EdgeInsetsGeometry? contentPadding;

  final GestureTapCallback? onTap;

  /// 给行布局添加底部线条, 默认使用[ThemeData]中[Divider]绘制线条
  /// 例: ItemNormalWidget布局原生中会绘制底部线条
  /// ListView(
  //   children: ItemNormalWidget.divideTiles(
  //     childs: <Widget>[
  //       ItemNormalWidget(
  //         leading: Icon(Icons.account_circle),
  //         title: Text("测试文本1"),
  //         onTap: () {},
  //       ),
  //       ItemNormalWidget(
  //         title: Text("测试文本2"),
  //         onTap: () {},
  //       ),
  //     ],
  //   ).toList(),
  // ),
  static Iterable<Widget> divideTiles({
    required Iterable<Widget> childs,
    Divider divider = const Divider(height: 0.0),
  }) sync* {
    assert(childs != null);

    final Iterator<Widget> iterator = childs.iterator;
    final bool isNotEmpty = iterator.moveNext();

    Widget child = iterator.current;
    while (iterator.moveNext()) {
      yield child = Material(
        child: Column(
          children: <Widget>[
            child,
            divider,
          ],
        ),
      );

      child = iterator.current;
    }
    if (isNotEmpty) {
      yield child;
    }
  }

  /// 基础Item定义, onTap不为空时显示右侧小箭头
  /// [icon] 左侧图标,可不定义
  ///
  /// [title] 标题文本
  ///
  /// [onTap] 点击事件
  static Widget item({
    Icon? icon,
    required String title,
    String? subtitle,
    final GestureTapCallback? onTap,
  }) {
    assert(title != null);
    return ItemNormalWidget(
      leading: icon,
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          : null,
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );
  }

  /// switch定义, onChanged
  /// [icon] 左侧图标,可不定义
  ///
  /// [title] 标题文本
  ///
  /// [value] 选择状态
  ///
  /// [onChanged] 点击事件
  static Widget switchItem({
    Icon? icon,
    required String title,
    bool value = false,
    final ValueChanged<bool>? onChanged,
  }) {
    assert(title != null);
    Widget switchWidget;
    if (Platform.isAndroid) {
      switchWidget = Switch(
        value: value,
        onChanged: onChanged,
      );
    } else {
      switchWidget = CupertinoSwitch(
        value: value,
        onChanged: onChanged,
      );
    }
    return ItemNormalWidget(
      leading: icon,
      title: Text(title),
      trailing: switchWidget,
      onTap: () {
        if (onChanged != null) {
          onChanged(value);
        }
      },
    );
  }

  /// 基础Item定义, onTap不为空时显示右侧小箭头
  /// [icon] 左侧图标,可不定义
  ///
  /// [title] 标题文本
  ///
  /// [onTap] 点击事件
  static Widget headItem({
    Widget? leading,
    required String title,
    String? subtitle,
    int? subtitleMaxLines,
    final GestureTapCallback? onTap,
  }) {
    assert(title != null);
    return ItemNormalWidget(
      leading: leading,
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              maxLines: subtitleMaxLines ?? 1,
            )
          : null,
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );
  }

  Color? _iconColor(ThemeData theme, ItemTileTheme tileTheme) {
    // if (!enabled) return theme.disabledColor;

    // if (selected && tileTheme?.selectedColor != null)
    //   return tileTheme.selectedColor;

    // if (!selected && tileTheme?.iconColor != null) return tileTheme.iconColor;

    // switch (theme.brightness) {
    //   case Brightness.light:
    //     return selected ? theme.primaryColor : Colors.black45;
    //   case Brightness.dark:
    //     return selected
    //         ? theme.accentColor
    //         : null; // null - use current icon theme color
    // }
    // assert(theme.brightness != null);
    return null;
  }

  Color _textColor(
      ThemeData theme, ItemTileTheme tileTheme, Color defaultColor) {
    // if (!enabled) return theme.disabledColor;

    // if (selected && tileTheme?.selectedColor != null)
    //   return tileTheme.selectedColor;

    if (tileTheme.textColor != null) {
      return tileTheme.textColor!;
    }

    // if (selected) {
    //   switch (theme.brightness) {
    //     case Brightness.light:
    //       return theme.primaryColor;
    //     case Brightness.dark:
    //       return theme.accentColor;
    //   }
    // }
    return defaultColor;
  }

  TextStyle _titleTextStyle(ThemeData theme, ItemTileTheme tileTheme) {
    TextStyle style = theme.textTheme.subtitle1!;
    if (tileTheme != null) {
      switch (tileTheme.style) {
        case ListTileStyle.drawer:
          style = theme.textTheme.bodyText1!;
          break;
        case ListTileStyle.list:
          style = theme.textTheme.subtitle1!;
          break;
        default:
          break;
      }
    }
    final Color color = _textColor(theme, tileTheme, style.color!);
    return style.copyWith(color: color);
  }

  TextStyle _subtitleTextStyle(ThemeData theme, ItemTileTheme tileTheme) {
    final TextStyle style = theme.textTheme.bodyText2!;
    final Color color =
        _textColor(theme, tileTheme, theme.textTheme.caption!.color!);
    return style.copyWith(color: color);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ItemTileTheme tileTheme = ItemTileTheme.of(context);

    IconThemeData iconThemeData = theme.iconTheme;
    if (leading != null || trailing != null)
      iconThemeData = IconThemeData(color: _iconColor(theme, tileTheme));
    Widget? leadingIcon;
    if (leading != null) {
      leadingIcon = Padding(
        padding: tileTheme.iconPadding ?? defaultIconPadding,
        child: IconTheme.merge(
          data: iconThemeData,
          child: leading!,
        ),
      );
    }

    final TextStyle titleStyle = _titleTextStyle(theme, tileTheme);
    final Widget titleText = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: title,
      ),
    );

    Widget? subtitleText;
    TextStyle subtitleStyle;
    if (subtitle != null) {
      subtitleStyle = _subtitleTextStyle(theme, tileTheme);
      subtitleText = AnimatedDefaultTextStyle(
        style: subtitleStyle,
        textAlign: TextAlign.right,
        duration: kThemeChangeDuration,
        child: Padding(
          padding: trailing == null
              ? const EdgeInsets.only(right: 8.0)
              : EdgeInsets.zero,
          child: subtitle,
        ),
      );
    }

    Widget? trailingIcon;
    if (trailing != null) {
      trailingIcon = Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: IconTheme.merge(
          data: iconThemeData,
          child: trailing!,
        ),
      );
    }
    const EdgeInsets _defaultContentPadding =
        EdgeInsets.symmetric(horizontal: 15.0);

    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets resolvedContentPadding =
        contentPadding?.resolve(textDirection) ??
            tileTheme.contentPadding?.resolve(textDirection) ??
            _defaultContentPadding;

    return Material(
      child: Ink(
        child: InkWell(
          onTap: onTap,
          child: SafeArea(
            top: false,
            bottom: false,
            minimum: resolvedContentPadding,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
                minHeight: tileTheme.minHeight,
              ),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  leadingIcon ?? const SizedBox.shrink(),
                  titleText,
                  // Spacer(),
                  Expanded(
                    child: subtitleText ?? const SizedBox.shrink(),
                  ),
                  trailingIcon ?? const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// An inherited widget that defines color and style parameters for [ListTile]s
/// in this widget's subtree.
///
/// Values specified here are used for [ListTile] properties that are not given
/// an explicit non-null value.
///
/// The [Drawer] widget specifies a tile theme for its children which sets
/// [style] to [ListTileStyle.drawer].
class ItemTileTheme extends InheritedTheme {
  /// Creates a list tile theme that controls the color and style parameters for
  /// [ListTile]s.
  const ItemTileTheme({
    Key? key,
    this.dense = false,
    this.style = ListTileStyle.list,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.iconPadding,
    this.contentPadding,
    this.minHeight = defaultItemHeight,
    required Widget child,
  }) : super(key: key, child: child);

  /// Creates a list tile theme that controls the color and style parameters for
  /// [ListTile]s, and merges in the current list tile theme, if any.
  ///
  /// The [child] argument must not be null.
  static Widget merge({
    Key? key,
    bool? dense,
    ListTileStyle? style,
    Color? selectedColor,
    Color? iconColor,
    Color? textColor,
    EdgeInsetsGeometry? contentPadding,
    double minHeight = defaultItemHeight,
    required Widget child,
  }) {
    assert(child != null);
    return Builder(
      builder: (BuildContext context) {
        final ItemTileTheme parent = ItemTileTheme.of(context);
        return ItemTileTheme(
          key: key,
          dense: dense ?? parent.dense,
          style: style ?? parent.style,
          selectedColor: selectedColor ?? parent.selectedColor,
          iconColor: iconColor ?? parent.iconColor,
          textColor: textColor ?? parent.textColor,
          contentPadding: contentPadding ?? parent.contentPadding,
          child: child,
        );
      },
    );
  }

  /// If true then [ListTile]s will have the vertically dense layout.
  final bool? dense;

  /// If specified, [style] defines the font used for [ListTile] titles.
  final ListTileStyle? style;

  /// If specified, the color used for icons and text when a [ListTile] is selected.
  final Color? selectedColor;

  /// If specified, the icon color used for enabled [ListTile]s that are not selected.
  final Color? iconColor;

  /// If specified, the text color used for enabled [ListTile]s that are not selected.
  final Color? textColor;

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  final EdgeInsetsGeometry? contentPadding;

  /// 图标Padding
  final EdgeInsetsGeometry? iconPadding;

  /// 最小高度
  final double minHeight;

  /// The closest instance of this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ListTileTheme theme = ListTileTheme.of(context);
  /// ```
  static ItemTileTheme of(BuildContext context) {
    final ItemTileTheme? result =
        context.dependOnInheritedWidgetOfExactType<ItemTileTheme>();
    return result ?? const ItemTileTheme(child: SizedBox());
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ItemTileTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<ItemTileTheme>();
    return identical(this, ancestorTheme)
        ? child
        : ItemTileTheme(
            dense: dense,
            style: style,
            selectedColor: selectedColor,
            iconColor: iconColor,
            textColor: textColor,
            contentPadding: contentPadding,
            child: child,
          );
  }

  @override
  bool updateShouldNotify(ItemTileTheme oldWidget) {
    return dense != oldWidget.dense ||
        style != oldWidget.style ||
        selectedColor != oldWidget.selectedColor ||
        iconColor != oldWidget.iconColor ||
        textColor != oldWidget.textColor ||
        contentPadding != oldWidget.contentPadding;
  }
}
