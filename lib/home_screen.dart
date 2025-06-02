import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'vcf_generator.dart';
import 'permissions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  final _codeController = TextEditingController();
  final _player = AudioPlayer();

  void _generateVCF() async {
    await _player.play(AssetSource('sounds/click.mp3'));
    final start = int.tryParse(_startController.text) ?? 0;
    final end = int.tryParse(_endController.text) ?? 0;
    final code = _codeController.text;
    final vcfContent = createBulkVCF(code, start, end);
    if (await requestPermission()) {
      await saveVCF(vcfContent);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('VCF file saved as ZAID BADANA VCF.vcf')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VCF Creator', style: GoogleFonts.lato()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Country Code (+XX)'),
            ),
            TextField(
              controller: _startController,
              decoration: InputDecoration(labelText: 'Start Number'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _endController,
              decoration: InputDecoration(labelText: 'End Number'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateVCF,
              child: Text('Generate VCF'),
            ),
          ],
        ),
      ),
    );
  }
}
