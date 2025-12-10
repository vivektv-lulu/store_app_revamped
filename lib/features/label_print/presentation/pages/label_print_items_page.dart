import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';

class LabelPrintItem {
  final String ean;
  final String name;
  final String quantity;

  LabelPrintItem({
    required this.ean,
    required this.name,
    required this.quantity,
  });
}

class LabelPrintItemsPage extends StatefulWidget {
  final String handheldNumber;
  final String labelType;
  final String printer;

  const LabelPrintItemsPage({
    super.key,
    required this.handheldNumber,
    required this.labelType,
    required this.printer,
  });

  @override
  State<LabelPrintItemsPage> createState() => _LabelPrintItemsPageState();
}

class _LabelPrintItemsPageState extends State<LabelPrintItemsPage> {
  final TextEditingController _eanController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final FocusNode _eanFocusNode = FocusNode();
  final FocusNode _qtyFocusNode = FocusNode();
  final List<LabelPrintItem> _lineItems = [];

  // Mock function to get article name from EAN
  String _getArticleNameFromEan(String ean) {
    // In real app, this would be an API call
    // For now, return mock data
    return 'Article for EAN $ean';
  }

  void _handleAddItem() {
    final ean = _eanController.text.trim();
    final qty = _qtyController.text.trim();

    if (ean.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter EAN',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    if (qty.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter quantity',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _lineItems.add(
        LabelPrintItem(
          ean: ean,
          name: _getArticleNameFromEan(ean),
          quantity: qty,
        ),
      );
      _eanController.clear();
      _qtyController.clear();
    });

    // Close keyboard when item is added
    _eanFocusNode.unfocus();
    _qtyFocusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _eanController.dispose();
    _qtyController.dispose();
    _eanFocusNode.dispose();
    _qtyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBg,
        foregroundColor: AppColors.textPrimary,
        title: const Text(
          'Label Print',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFF0FFF4), AppColors.surface],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Input Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // EAN Field
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _eanController,
                            focusNode: _eanFocusNode,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              labelText: 'EAN',
                              hintText: 'Scan or enter EAN',
                              filled: true,
                              fillColor: AppColors.inputFill,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColors.primary.withOpacity(0.2),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColors.primary.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            onSubmitted: (_) {
                              _qtyFocusNode.requestFocus();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Quantity Field
                        Expanded(
                          child: TextField(
                            controller: _qtyController,
                            focusNode: _qtyFocusNode,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              labelText: 'Qty',
                              hintText: 'Qty',
                              filled: true,
                              fillColor: AppColors.inputFill,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColors.primary.withOpacity(0.2),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColors.primary.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            onSubmitted: (_) => _handleAddItem(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Plus Button
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _handleAddItem,
                              borderRadius: BorderRadius.circular(10),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Line Items Table
              Flexible(
                child: _lineItems.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            'No items added yet',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Text(
                                'Line Items',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primary.withOpacity(0.1),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Table Header
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(
                                        0.08,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'EAN / Name',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 16,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          color: AppColors.primary.withOpacity(
                                            0.2,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: Text(
                                            'Quantity',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Table Rows
                                  ...List.generate(_lineItems.length, (index) {
                                    final item = _lineItems[index];
                                    final isLast =
                                        index == _lineItems.length - 1;
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: isLast
                                              ? BorderSide.none
                                              : BorderSide(
                                                  color: AppColors.primary
                                                      .withOpacity(0.1),
                                                  width: 1,
                                                ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.ean,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColors.textPrimary,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    item.name,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          AppColors.textMuted,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 16,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
                                              color: AppColors.primary
                                                  .withOpacity(0.1),
                                            ),
                                            SizedBox(
                                              width: 80,
                                              child: Text(
                                                item.quantity,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.textPrimary,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
