import 'package:flutter/material.dart';

class MyInputTextFormField extends StatefulWidget {
  final TextEditingController _controller;
  final TextInputType _keyboardType;
  final TextInputAction _textInputAction;
  final String _initialValue;
  final String _hintText;
  final String _lableText;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final bool _autoFocus;

  const MyInputTextFormField({
    Key key,
    @required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    String initialValue,
    String hintText = '',
    String lableText = '',
    this.focusNode,
    this.nextFocusNode,
    bool autoFocus = false,
  })  : _controller = controller,
        _keyboardType = keyboardType,
        _textInputAction = textInputAction,
        _initialValue = initialValue,
        _hintText = hintText,
        _lableText = lableText,
        _autoFocus = autoFocus,
        super(key: key);
  @override
  _MyInputTextFormFieldState createState() => _MyInputTextFormFieldState();
}

class _MyInputTextFormFieldState extends State<MyInputTextFormField> {
  void _onListener() => setState(() {});
  @override
  void initState() {
    super.initState();
    widget._controller.addListener(() => _onListener);
  }

  @override
  void dispose() {
    widget._controller.removeListener(() => _onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: widget._controller,
        keyboardType: widget._keyboardType,
        textInputAction: widget._textInputAction,
        initialValue: widget._initialValue,
        focusNode: widget.focusNode,
        autofocus: widget._autoFocus,
        decoration: InputDecoration(
          hintText: widget._hintText,
          labelText: widget._lableText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
