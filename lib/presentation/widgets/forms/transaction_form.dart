
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/helpers/form_validation.dart';
import '../../../core/utils/app_toasts.dart';
import '../../../data/models/transaction_model.dart';
import '../../bloc/transaction_bloc/transactions_bloc.dart';
import '../common/form_field.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key, required this.recipientNameController});
  final TextEditingController recipientNameController;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    widget.recipientNameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AmountInputField(amountController: amountController),
          const SizedBox(height: 12.0),
          const SizedBox(height: 20.0),
          SendMoneyBtn(
            formKey: formKey,
            recipientNameController: widget.recipientNameController,
            amountController: amountController,
          ),
        ],
      ),
    );
  }
}

class AmountInputField extends StatelessWidget {
  const AmountInputField({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: amountController,
      label: "Amount",
      icon: CupertinoIcons.money_dollar_circle_fill,
      obscureText: false,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter valid amount!';
        }

        // Allow numbers with commas (e.g., 1,000.50)
        final cleaned = value.replaceAll(',', '');
        final parsed = double.tryParse(cleaned);
        return FormValidation.validateAmount(parsed);
      },
    );
  }
}

class SendMoneyBtn extends StatelessWidget {
  const SendMoneyBtn({
    super.key,
    required this.formKey,
    required this.recipientNameController,
    required this.amountController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController recipientNameController;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth currentUser = FirebaseAuth.instance;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final form = formKey.currentState;

          if (form != null && form.validate()) {
            final counterparty = recipientNameController.text.trim();
            final amountText = amountController.text.trim().replaceAll(',', '');
            final amount = double.tryParse(amountText);

            final validationError = FormValidation.validateAmount(amount);
            if (validationError != null) {
              AppToast.showError(context, title: validationError);
              return;
            }

            final txn = TransactionModel(
              id: const Uuid().v4(),
              type: 'send',
              amount: amount!,
              currency: 'KES',
              senderName: currentUser.currentUser?.displayName,
              counterparty: counterparty,
              date: DateTime.now(),
            );

            // Dispatch send request to bloc
            context.read<TransactionsBloc>().add(SendMoneyRequested(txn));

            // Optionally clear form
            recipientNameController.clear();
            amountController.clear();
          }
        },
        child: const Text(
          'Send Money',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
