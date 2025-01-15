import 'package:flutter/material.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/drag_drop_file.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/drag_view.dart';
import 'package:mate_order_super_user/constants.dart';

class CustomAddProductDialog extends StatelessWidget {
  CustomAddProductDialog({super.key});
  final _formKey = GlobalKey<FormState>();
  final List<String> _categories = ['Personal', 'Work', 'Other'];
  String? _category;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(6, 6),
                spreadRadius: 2,
                blurStyle: BlurStyle.solid,
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: CloseButton(),
                  ),
                  const Center(
                    child: Text(
                      'Add product',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: kPrimaryColor10,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _category,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      isExpanded: true,
                      items: _categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        // setState(() {
                        //   _category = value;
                        // });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a category' : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Product name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: kPrimaryColor10,
                    ),
                    onChanged: (value) {
                      //
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a task title' : null,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Amount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: kPrimaryColor10,
                    ),
                    onChanged: (value) {
                      //
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter amount' : null,
                  ),
                  const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: kPrimaryColor10,
                    ),
                    onChanged: (value) {
                      //
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter amount' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DragView();
                          },
                        ));
                      },
                      child: Text('Add photo')),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // if (_category == 'Other' &&
                          //     _newCategory != null &&
                          //     _newCategory!.isNotEmpty) {
                          //   _categories.add(_newCategory!);
                          //   _category = _newCategory;
                          // }
                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.amber), //////
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
