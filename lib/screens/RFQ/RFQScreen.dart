import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pakmart/api/RFQ.dart';
import 'package:pakmart/constant/screensize.dart';
import 'package:pakmart/constant/textStyles.dart';
import 'package:pakmart/service/SnackBar.dart';

class RFQScreen extends StatefulWidget {
  RFQScreen({super.key, this.isBackButtonEnable = false});

  bool isBackButtonEnable;

  @override
  State<RFQScreen> createState() => _MyFormState();
}

class _MyFormState extends State<RFQScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _customTitleController = TextEditingController();
  final TextEditingController _productRequiredController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  String Location = "Karachi";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _customTitleController.dispose();
    _productRequiredController.dispose();
    _quantityController.dispose();
    _deliveryTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.isBackButtonEnable ? true : false,
        centerTitle: true,
        title: const Text('RFQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                const Text(
                  "RFQ",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Title',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    if (!value.toLowerCase().startsWith('request for')) {
                      return 'The title must start with "Request for"';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _customTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Custom Title ',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the custom title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _productRequiredController,
                  decoration: const InputDecoration(
                    labelText: 'Product Required',
                    prefixIcon: Icon(Icons.shopping_cart),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the product required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    prefixIcon: Icon(Icons.inventory),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _deliveryTimeController,
                  readOnly: true, // Prevents keyboard input
                  decoration: const InputDecoration(
                    labelText: 'Preferred Delivery Time',
                    prefixIcon: Icon(Icons.calendar_month_rounded),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(), // No past dates
                      lastDate: DateTime(2100), // Set a future date limit
                    );

                    if (selectedDate != null) {
                      // Format the date and set it in the TextEditingController
                      _deliveryTimeController.text =
                          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the preferred delivery time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Select your Location",
                  style: boldWith18px,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 5,
                      right: Screensize(context: context).screenWidth / 2),
                  child: DropdownButton(
                    value: Location,
                    isExpanded: true,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.green,
                    ),
                    items: ["Karachi", "Lahore"].map(
                      (String value) {
                        return DropdownMenuItem(
                            value: value, child: Text(value));
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        Location = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 100)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // int? quantity = int.tryParse(_quantityController.text);

                        final response = await RFQApi.create_RFQ(
                            title: _titleController.text,
                            customTitle: _customTitleController.text,
                            productRequired: _productRequiredController.text,
                            quantity: _quantityController.text,
                            deliveryTime: _deliveryTimeController.text,
                            Location: Location);

                        if (response == 201) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'RFQ has been send',
                            autoHide: const Duration(seconds: 2),
                            onDismissCallback: (type) {
                              _titleController.clear();
                              _customTitleController.clear();
                              _deliveryTimeController.clear();
                              _quantityController.clear();
                              _productRequiredController.clear();
                            },
                          ).show();
                        } else if (response == 404) {
                          CallSnackbar()
                              .callSnakBar(context, "Product does not exist");
                        } else if (response == 403) {
                          CallSnackbar().callSnakBar(context,
                              "The Person already sended RFQ for this product");
                        } else {
                          CallSnackbar().callSnakBar(
                              context, "$response Some backend error");
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
