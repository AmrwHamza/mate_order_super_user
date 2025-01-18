import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_order_super_user/Features/Home/data/models/dropped_file.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/drag_view.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/add_product/add_product_cubit.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/get_all_products/get_all_products_cubit.dart';
import 'package:mate_order_super_user/constants.dart';

class CustomAddProductDialog extends StatefulWidget {
  const CustomAddProductDialog({super.key});

  @override
  State<CustomAddProductDialog> createState() => _CustomAddProductDialogState();
}

class _CustomAddProductDialogState extends State<CustomAddProductDialog> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _categories = [
    'Food',
    'Drinks',
    'Clothes',
    'Toys',
    'Books',
    'Tools',
    'Electronics',
    'Furniture',
    'Kitchen',
  ];

  String? _category;

  DroppedFile? file;

  String? _productName;

  int? _amount;

  double? _price;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              // BoxShadow(
              //   color: Colors.black,
              //   offset: Offset(6, 6),
              //   spreadRadius: 2,
              //   blurStyle: BlurStyle.solid,
              // ),
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
                        setState(() {
                          _category = value;
                        });
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
                      _productName = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a product name' : null,
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
                      _amount = int.tryParse(value);
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter an amount' : null,
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
                      _price = double.tryParse(value);
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a price' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(kPrimaryColor9)),
                      onPressed: () async {
                        final selectedFile = await Navigator.push<DroppedFile>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DragView(),
                          ),
                        );
                        if (selectedFile != null) {
                          file = selectedFile; 
                        }
                      },
                      child: const Text(
                        'Add photo',
                        style: TextStyle(color: Colors.black),
                      )),
                  const SizedBox(height: 20),
                  BlocConsumer<AddProductCubit, AddProductState>(
                    listener: (context, state) {
                      if (state is AddProductSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Product added successfully!')),
                        );
                        context.read<GetAllProductsCubit>().getProducts();
                        Navigator.pop(context);
                      } else if (state is AddProductError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${state.message}')),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AddProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                file != null) {
                              context.read<AddProductCubit>().addProduct(
                                    name: _productName!,
                                    amount: _amount!,
                                    price: _price!,
                                    category: _category!,
                                    file: file!,
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please fill all fields and add a photo')),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(
                                Colors.amber), //////
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
                      );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
