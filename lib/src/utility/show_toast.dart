
import 'package:flutter/material.dart';

void showToast(
    BuildContext context, IconData icon, String message, String type) {
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (BuildContext context) => Positioned(
      bottom: MediaQuery.of(context).size.height *
          0.05, // Adjust the position as needed
      left: 10,
      right: 10,
      //width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: type == 'error' ? Colors.red : Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    maxLines: null,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context)?.insert(overlayEntry);

  // Hide the toast after a delay
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
