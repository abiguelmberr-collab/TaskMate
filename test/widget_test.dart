
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_mate/main.dart';
import 'package:task_mate/providers/task_provider.dart';

void main() {
  testWidgets('TaskMate app smoke test', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: const TaskMateApp(),
      ),
    );

    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
