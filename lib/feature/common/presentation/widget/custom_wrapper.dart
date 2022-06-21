import 'package:fit_tracker/feature/common/utils/helper/focus_helper.dart';
import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({
    Key? key,
    required Widget child,
  })  : _child = child,
        super(key: key);

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1,
      ),
      child: GestureDetector(
          onTap: () {
            FocusUtils(context).unfocus();
          },
          child: _child),
    );
  }
}

/// Custom Widget for make a `Container` with `Padding` inside a `Sliver Widget`
class SliverBoxPadding extends StatelessWidget {
  const SliverBoxPadding({
    Key? key,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    required Widget child,
    Color background = Colors.transparent,
  })  : _padding = padding,
        _child = child,
        _background = background,
        super(key: key);

  final EdgeInsetsGeometry _padding;
  final Widget _child;
  final Color _background;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: _padding,
        color: _background,
        child: _child,
      ),
    );
  }
}

/// Custom Widget for make a `Column` with `Padding` inside a `non-Sliver widget`
class ColumnPadding extends StatelessWidget {
  const ColumnPadding({
    Key? key,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    required List<Widget> children,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Color background = Colors.transparent,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  })  : _padding = padding,
        _children = children,
        _background = background,
        _mainAxisSize = mainAxisSize,
        _mainAxisAlignment = mainAxisAlignment,
        _crossAxisAlignment = crossAxisAlignment,
        super(key: key);

  final EdgeInsetsGeometry _padding;
  final List<Widget> _children;
  final Color _background;
  final MainAxisSize _mainAxisSize;
  final MainAxisAlignment _mainAxisAlignment;
  final CrossAxisAlignment _crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: _background,
      ),
      child: Column(
        mainAxisSize: _mainAxisSize,
        mainAxisAlignment: _mainAxisAlignment,
        crossAxisAlignment: _crossAxisAlignment,
        children: _children,
      ),
    );
  }
}

/// Custom Widget for make a `Row` with `Padding` inside a `non-Sliver Widget`
class RowPadding extends StatelessWidget {
  const RowPadding({
    Key? key,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    required List<Widget> children,
    Color background = Colors.transparent,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  })  : _padding = padding,
        _children = children,
        _background = background,
        _mainAxisAlignment = mainAxisAlignment,
        _crossAxisAlignment = crossAxisAlignment,
        super(key: key);

  final EdgeInsetsGeometry _padding;
  final List<Widget> _children;
  final Color _background;
  final MainAxisAlignment _mainAxisAlignment;
  final CrossAxisAlignment _crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      color: _background,
      child: Row(
        mainAxisAlignment: _mainAxisAlignment,
        crossAxisAlignment: _crossAxisAlignment,
        children: _children,
      ),
    );
  }
}

/// Custom Widget for make a `Column` with `Padding` inside a `Sliver Widget`
class SliverColumnPadding extends StatelessWidget {
  const SliverColumnPadding({
    Key? key,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    required List<Widget> children,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Color background = Colors.transparent,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  })  : _padding = padding,
        _children = children,
        _background = background,
        _mainAxisSize = mainAxisSize,
        _mainAxisAlignment = mainAxisAlignment,
        _crossAxisAlignment = crossAxisAlignment,
        super(key: key);

  final EdgeInsetsGeometry _padding;
  final List<Widget> _children;
  final Color _background;
  final MainAxisSize _mainAxisSize;
  final MainAxisAlignment _mainAxisAlignment;
  final CrossAxisAlignment _crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: _background,
        padding: _padding,
        child: Column(
          mainAxisSize: _mainAxisSize,
          mainAxisAlignment: _mainAxisAlignment,
          crossAxisAlignment: _crossAxisAlignment,
          children: _children,
        ),
      ),
    );
  }
}

/// Custom Widget for make a `Row` with `Padding` inside a `Sliver Widget`
class SliverRowPadding extends StatelessWidget {
  const SliverRowPadding({
    Key? key,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    required List<Widget> children,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Color background = Colors.transparent,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  })  : _padding = padding,
        _children = children,
        _background = background,
        _mainAxisSize = mainAxisSize,
        _mainAxisAlignment = mainAxisAlignment,
        _crossAxisAlignment = crossAxisAlignment,
        super(key: key);

  final EdgeInsetsGeometry _padding;
  final List<Widget> _children;
  final Color _background;
  final MainAxisSize _mainAxisSize;
  final MainAxisAlignment _mainAxisAlignment;
  final CrossAxisAlignment _crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: _background,
        padding: _padding,
        child: Row(
          mainAxisSize: _mainAxisSize,
          mainAxisAlignment: _mainAxisAlignment,
          crossAxisAlignment: _crossAxisAlignment,
          children: _children,
        ),
      ),
    );
  }
}
