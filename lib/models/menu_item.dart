import 'package:flutter/material.dart';

enum MenuAction { viewNews, addNews, logout }

class MenuItemData {
  const MenuItemData({
    required this.title,
    required this.icon,
    required this.color,
    required this.message,
    required this.action,
  });

  final String title;
  final IconData icon;
  final Color color;
  final String message;
  final MenuAction action;
}
