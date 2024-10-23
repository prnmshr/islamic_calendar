// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'get_date.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Converter',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/calendar.png',
              width: 128,
            ),
            const SizedBox(height: 10),
            const Text('ISLAMIC CALENDAR CONVERTER',
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConvertToHijriScreen(),
                    ),
                  );
                },
                child: const Text('Konversi Masehi ke Hijriah')),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConvertToGregorianScreen(),
                    ),
                  );
                },
                child: const Text('Konversi Hijriah ke Masehi')),
            const SizedBox(height: 200),
            const Text(
              'An App by Purnama Ashari',
              style: TextStyle(fontSize: 7, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ConvertToHijriScreen extends StatefulWidget {
  const ConvertToHijriScreen({super.key});

  @override
  _ConvertToHijriScreenState createState() => _ConvertToHijriScreenState();
}

class _ConvertToHijriScreenState extends State<ConvertToHijriScreen> {
  String selectedDay = '1';
  String selectedMonth = '1';
  String selectedYear = '2024';

  List<String> days = List.generate(31, (index) => (index + 1).toString());
  List<String> months = List.generate(12, (index) => (index + 1).toString());
  List<String> years = List.generate(100, (index) => (1924 + index).toString());

  String hijriDate = '';

  TextEditingController yearController = TextEditingController();

  void _convertToHijri() async {
    String date = '$selectedDay-$selectedMonth-$selectedYear';
    final result = await fetchDateFromGregorian(date);

    if (result != null) {
      setState(() {
        // Mengubah output hijriah menjadi teks dengan nama bulan
        hijriDate =
            '${result.data.hijri.day} ${result.data.hijri.month.en} ${result.data.hijri.year}';
      });
    } else {
      setState(() {
        hijriDate = 'Konversi gagal';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Masehi ke Hijriah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedDay,
              onChanged: (newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: days.map((day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Pilih Tanggal'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedMonth,
              onChanged: (newValue) {
                setState(() {
                  selectedMonth = newValue!;
                });
              },
              items: months.map((month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Pilih Bulan'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Masukkan Tahun'),
              keyboardType: TextInputType.number, // keyboard angka
              onChanged: (newValue) {
                setState(() {
                  selectedYear = newValue;
                });
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _convertToHijri,
              child: const Text('Konversi ke Hijriah'),
            ),
            const SizedBox(height: 50),
            Text(
              hijriDate.isEmpty
                  ? 'Tanggal Hijriah akan muncul di sini'
                  : hijriDate, // Menampilkan hasil konversi
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}

class ConvertToGregorianScreen extends StatefulWidget {
  const ConvertToGregorianScreen({super.key});

  @override
  _ConvertToGregorianScreenState createState() =>
      _ConvertToGregorianScreenState();
}

class _ConvertToGregorianScreenState extends State<ConvertToGregorianScreen> {
  String selectedDay = '1';
  String selectedMonth = '1';
  String selectedYear = '1445';

  List<String> days = List.generate(30, (index) => (index + 1).toString());
  List<String> months = List.generate(12, (index) => (index + 1).toString());
  List<String> years =
      List.generate(1500, (index) => (1000 + index).toString());

  String gregorianDate = '';

  TextEditingController yearController = TextEditingController();

  void _convertToGregorian() async {
    String date = '$selectedDay-$selectedMonth-$selectedYear';
    final result = await fetchDateFromHijri(date);
    if (result != null) {
      setState(() {
        gregorianDate = '${result.data.gregorian.day} ${result.data.gregorian.month.en} ${result.data.gregorian.year}';
      });
    } else {
      setState(() {
        gregorianDate = 'Konversi gagal';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Hijriah ke Masehi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedDay,
              onChanged: (newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: days.map((day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Pilih Tanggal'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedMonth,
              onChanged: (newValue) {
                setState(() {
                  selectedMonth = newValue!;
                });
              },
              items: months.map((month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Pilih Bulan'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Masukkan Tahun'),
              keyboardType: TextInputType.number, // keyboard angka
              onChanged: (newValue) {
                setState(() {
                  selectedYear = newValue;
                });
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _convertToGregorian,
              child: const Text('Konversi ke Masehi'),
            ),
            const SizedBox(height: 50),
            Text(
              gregorianDate.isEmpty
                  ? 'Tanggal Masehi akan muncul di sini'
                  : gregorianDate,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
