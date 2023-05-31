//! This is a custom widget for multi select action chip

import 'package:flutter/material.dart';
import 'package:new_on_the_tee/utils/colors.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';

class MultiSelectActionChip extends StatefulWidget {
  final List<String?> items;
  final List<String?> selectedItems;
  final ValueChanged<List<String?>> onTap;

  const MultiSelectActionChip(
      {super.key,
      required this.items,
      required this.onTap,
      required this.selectedItems});

  @override
  State<MultiSelectActionChip> createState() => _MultiSelectActionChipState();
}

class _MultiSelectActionChipState extends State<MultiSelectActionChip> {
  List<String?> selectedItems = [];
  @override
  void initState() {
    selectedItems = widget.selectedItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      direction: Axis.horizontal,
      children: List.generate(
        widget.items.length,
        (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedItems.contains(widget.items[index])) {
                  selectedItems.remove(widget.items[index]);
                } else {
                  selectedItems.add(widget.items[index]);
                }
              });
              widget.onTap(selectedItems);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: selectedItems.contains(widget.items[index])
                      ? Kcolors.brandGreen
                      : Kcolors.grey300,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(widget.items[index] ?? '',
                        style: selectedItems.contains(widget.items[index])
                            ? montserrat(Kcolors.white, 12)
                            : montserrat(Kcolors.grey400, 12))),
              ),
            ),
          );
        },
      ),
    );
  }
}

//! This is a custom widget for single select action chip

class SingleSelectActionChip extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onTap;

  const SingleSelectActionChip(
      {super.key,
      required this.items,
      required this.onTap,
      required this.selectedItem});

  @override
  State<SingleSelectActionChip> createState() => _SingleSelectActionChipState();
}

class _SingleSelectActionChipState extends State<SingleSelectActionChip> {
  String? selectedItem;
  @override
  void initState() {
    selectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      direction: Axis.horizontal,
      children: List.generate(
        widget.items.length,
        (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedItem = widget.items[index];
              });
              widget.onTap(selectedItem);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: selectedItem == widget.items[index]
                      ? Kcolors.brandGreen
                      : Kcolors.grey300,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(widget.items[index],
                        style: selectedItem == widget.items[index]
                            ? montserrat(Kcolors.white, 12)
                            : montserrat(Kcolors.grey400, 12))),
              ),
            ),
          );
        },
      ),
    );
  }
}
