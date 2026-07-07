import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thumbnail Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ThumbnailEditorScreen(),
      },
    );
  }
}

class ThumbnailEditorScreen extends StatefulWidget {
  const ThumbnailEditorScreen({super.key});

  @override
  State<ThumbnailEditorScreen> createState() => _ThumbnailEditorScreenState();
}

class _ThumbnailEditorScreenState extends State<ThumbnailEditorScreen> {
  String _title = 'Awesome Video Title';
  Color _bgColor = Colors.blueGrey.shade900;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thumbnail Maker'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return Row(
            children: [
              if (!isMobile)
                Expanded(
                  flex: 1,
                  child: _buildControls(),
                ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    if (isMobile) _buildControls(),
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _bgColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                )
                              ],
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  _title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black54,
                                        blurRadius: 8,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Text', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter title',
            ),
            onChanged: (val) {
              setState(() {
                _title = val.isNotEmpty ? val : 'Awesome Video Title';
              });
            },
          ),
          const SizedBox(height: 16),
          const Text('Background Color', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _colorBtn(Colors.blueGrey.shade900),
              _colorBtn(Colors.red.shade800),
              _colorBtn(Colors.green.shade800),
              _colorBtn(Colors.blue.shade800),
              _colorBtn(Colors.purple.shade800),
              _colorBtn(Colors.orange.shade800),
            ],
          ),
        ],
      ),
    );
  }

  Widget _colorBtn(Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          _bgColor = color;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _bgColor == color ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
            )
          ],
        ),
      ),
    );
  }
}
