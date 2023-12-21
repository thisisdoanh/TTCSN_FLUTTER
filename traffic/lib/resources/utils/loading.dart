import 'package:flutter/material.dart';

List<OverlayEntry> createOverlayLoading(BuildContext context) {
  List<OverlayEntry> entries = [];
  entries.add(OverlayEntry(
    builder: (context) => ModalBarrier(color: Colors.black.withOpacity(0.1)),
  ));
  entries.add(OverlayEntry(builder: (context) {
    return SizedBox(
      child: Center(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          color: Colors.black.withOpacity(0.4),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  child: Text(
                    'Loading data...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }));
  return entries;
}
