import 'dart:ui';
import 'package:flutter/material.dart';

class SelectableCategoryImageWidget extends StatefulWidget {
  final int index;
  final String imageURL;
  final String name;
  final bool isSelected;
  final Function onClick;
  const SelectableCategoryImageWidget({
    Key key,
    @required this.index,
    @required this.imageURL,
    @required this.name,
    @required this.isSelected,
    @required this.onClick,
  }) : super(key: key);
  @override
  _SelectableCategoryImageWidgetState createState() =>
      _SelectableCategoryImageWidgetState();
}

class _SelectableCategoryImageWidgetState
    extends State<SelectableCategoryImageWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  void initState() {
    super.initState();

    controller = AnimationController(
      value: widget.isSelected ? 1 : 0,
      duration: kThemeChangeDuration,
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
  }

  @override
  void didUpdateWidget(SelectableCategoryImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        controller.forward();
      } else {
        controller.reverse();
      }
      widget.onClick(widget.index, widget.isSelected);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: scaleAnimation.value,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.isSelected ? 80 : 16),
          child: child,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(widget.imageURL)),
              borderRadius: (widget.isSelected)
                  ? BorderRadius.all(Radius.circular(80.0))
                  : BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: (widget.isSelected)
                  ? Colors.black.withOpacity(0.5)
                  : Colors.black.withOpacity(0.4),
              borderRadius: (widget.isSelected)
                  ? BorderRadius.all(Radius.circular(80.0))
                  : BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            left: 10,
            child: Center(
              child: Text(
                widget.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
