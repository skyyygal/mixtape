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
                          width: 350,
                          height: 250,
                          child: SvgPicture.asset("asset/images/cassette.svg"),
                        ),
                        const SizedBox(height: 32),
                        buildCassetteTape(),
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
              child: SizedBox(
                height: 20,
                // decoration: BoxDecoration(color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     // Left Slash
          //     Transform.rotate(
          //       angle: 0.5, // roughly -30 degrees in radians
          //       child: Container(width: 2, height: 20, color: Colors.brown),
          //     ),

          //     // Horizontal Line
          //     Expanded(
          //       child: Container(
          //         height: 2,
          //         color: Colors.brown,
          //         margin: const EdgeInsets.symmetric(horizontal: 8),
          //       ),
          //     ),

          //     // Right Slash
          //     Transform.rotate(
          //       angle: -0.5, // roughly +30 degrees in radians
          //       child: Container(width: 2, height: 20, color: Colors.brown),
          //     ),
          //   ],
          // ),
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
        const SizedBox(height: 40),

        // Footer
        const Center(
          child: Text(
            '© 2025 Skyyygal MIXTAPES • ALL RIGHTS RESERVED',
            style: TextStyle(fontSize: 12, color: Colors.grey),
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

class _TapeWheel extends StatelessWidget {
  const _TapeWheel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD19A4E), // brown
          ),
        ),
      ),
    );
  }
}

class _TapeButton extends StatelessWidget {
  const _TapeButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
