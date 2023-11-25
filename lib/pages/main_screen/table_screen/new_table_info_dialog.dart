import 'package:coozy_cafe/AppLocalization.dart';
import 'package:coozy_cafe/model/table_info_model.dart';
import 'package:coozy_cafe/utlis/components/string_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTableDialog extends StatefulWidget {
  final Function(TableInfoModel) onCreate;

  NewTableDialog({required this.onCreate});

  @override
  _NewTableDialogState createState() => _NewTableDialogState();
}

class _NewTableDialogState extends State<NewTableDialog> {
  late TextEditingController _tableNameController;
  FocusNode? _tableNameFocusNode;
  late TextEditingController _nosOfChairsController;
  FocusNode? _nosOfChairsFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tableNameController = TextEditingController(text: "");
    _tableNameFocusNode = FocusNode();
    _nosOfChairsFocusNode = FocusNode();
    _nosOfChairsController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Table'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _tableNameController,
                    focusNode: _tableNameFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Table Name',
                      hintText: 'Enter table name like Table1',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Table name is required.";
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context)
                          .requestFocus(_nosOfChairsFocusNode);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    focusNode: _nosOfChairsFocusNode,
                    controller: _nosOfChairsController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Nos Of Chairs per Table',
                      hintText: 'Enter number of chairs',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(AppLocalizations.of(context)
                  ?.translate(StringValue.common_cancel) ??
              "cancel"),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              String tableName = _tableNameController.text;
              int? nosOfChairs = int.tryParse(_nosOfChairsController.text.toString());
              TableInfoModel tableInfoModel = TableInfoModel(name: tableName, nosOfChairs: nosOfChairs ?? 4);
              widget.onCreate(tableInfoModel);
            }
          },
          child: Text(AppLocalizations.of(context)
                  ?.translate(StringValue.common_submit) ??
              "Submit"),
        ),
      ],
    );
  }
}
