import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/Model/RFQModel.dart';
import 'package:pakmart/SellerCentral/config/components/status_button.dart';
import 'package:pakmart/SellerCentral/views/receive_leads/widgets/status_button_widget.dart';

class LeadDetailsWidget extends StatelessWidget {
  final RFQ lead;
  const LeadDetailsWidget({required this.lead, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.7, // increased height
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'RFQ Details',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('_id', lead.rfqId ?? ""),
            _buildDetailRow('Title', lead.title),
            _buildDetailRow('Custom Title', lead.customTitle),
            _buildDetailRow('Product Required', lead.productRequired),
            _buildDetailRow('Quantity', lead.quantity.toString()),
            _buildDetailRow('Delivery Time', lead.deliveryTime),
            _buildDetailRow('Location', lead.Location),
            _buildDetailRow('Customer ID', lead.customerId),

            const Spacer(), // push buttons to bottom

            StatusButtons(rfqId: lead.rfqId ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
