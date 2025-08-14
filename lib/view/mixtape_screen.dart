import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MixtapeScreen extends StatefulWidget {
  const MixtapeScreen({super.key});

  @override
  State<MixtapeScreen> createState() => _MixtapeScreenState();
}

class _MixtapeScreenState extends State<MixtapeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final List<TextEditingController> _urlControllers = [TextEditingController()];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 450,
                          height: 350,
                          child: SvgPicture.asset("asset/images/cassette.svg"),
                        ),
                        const SizedBox(height: 32),
                        buildCassetteTape(),
                        Spacer(),
                        // Footer
                        const Center(
                          child: Text(
                            '© 2025 Skyyygal MIXTAPES • ALL RIGHTS RESERVED',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCassetteTape() {
    return Container(
      padding: EdgeInsets.all(8),
      width: 350,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Beige Top Section (Tape Label Area)
          Container(
            height: 110,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5E8D0), // beige
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset("asset/images/musical.svg"),
          ),

          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFE2A96B), // brown
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Container(
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SvgPicture.asset(
                        "asset/images/wheel.svg",
                        height: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SvgPicture.asset(
                        "asset/images/wheel.svg",
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: CustomPaint(painter: CassetteOutlinePainter()),
          ),
        ],
      ),
    );
  }

  Widget buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recipient Name Section
        const Text(
          'RECIPIENT NAME (OPTIONAL):',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          onChanged: (value) => setState(() {}),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Mixtape will be labeled ',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              TextSpan(
                text:
                    '"${_nameController.text.isNotEmpty ? _nameController.text : 'Recipient'}\'s Mix"',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // YouTube Links Section
        const Text(
          'ADD YOUTUBE LINKS (MAX 5):',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            for (int i = 0; i < _urlControllers.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Text(
                      '${i + 1}:',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _urlControllers[i],
                        decoration: InputDecoration(
                          hintText: 'Paste YouTube URL here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        if (_urlControllers.length < 5)
          TextButton(
            onPressed: () {
              setState(() {
                _urlControllers.add(TextEditingController());
              });
            },
            child: Text(
              'ADD ANOTHER TRACK (${_urlControllers.length}/5)',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        const SizedBox(height: 32),

        // Create Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Handle mixtape creation
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'CREATE MIXTAPE 😊',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (var controller in _urlControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class CassetteOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFF5A3E2B)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(50, size.height);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(size.width * 0.8, 0);
    path.lineTo(size.width * 0.85, size.height);

    canvas.drawPath(path, paint);

    // 🎵 Dots (the circles)
    final dotPaint = Paint()..color = const Color(0xFFF5E8D0);
    const double radius = 5;

    // Left dots
    canvas.drawCircle(
      Offset(size.width * 0.3, size.height / 2),
      radius,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height / 2),
      radius,
      dotPaint,
    );

    // Right dots
    canvas.drawCircle(
      Offset(size.width * 0.6, size.height / 2),
      radius,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height / 2),
      radius,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
