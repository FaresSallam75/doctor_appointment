import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
  String name,
  ThemeData theme,
  void Function()? onPressedIconBack,
  void Function()? onPressedVoiceCall,
  void Function()? onPressedVideoCall,
) {
  return AppBar(
    title: Text(name),
    backgroundColor: theme.colorScheme.surface, // Match scaffold background
    foregroundColor: theme.colorScheme.onSurface, // Text/icon color
    elevation: 1.0, // Subtle shadow
    leading: BackButton(onPressed: onPressedIconBack),
    actions: [
      IconButton(
        icon: const Icon(Icons.call_outlined),
        onPressed: onPressedVoiceCall,
        tooltip: 'اتصال صوتي',
      ),
      IconButton(
        icon: const Icon(Icons.videocam_outlined),
        onPressed: onPressedVideoCall,
        tooltip: 'اتصال فيديو',
      ),
      IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () {
          /* TODO: Implement info action */
        },
        tooltip: 'معلومات',
      ),
    ],
  );
}
