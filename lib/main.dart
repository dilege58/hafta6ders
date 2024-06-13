import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kişilik Anketi'),
          backgroundColor: Colors.orange,
        ),
        body: KisilikAnketFormu(),
      ),
    );
  }
}

class KisilikAnketFormu extends StatefulWidget {
  @override
  _KisilikAnketFormuDurum createState() => _KisilikAnketFormuDurum();
}

class _KisilikAnketFormuDurum extends State<KisilikAnketFormu> {
  final _formKey = GlobalKey<FormState>();
  String _isim = '';
  String? _cinsiyet = null;  // Initial value should be null to avoid conflict
  bool _resitMi = false;
  bool _sigaraKullaniyorMu = false;
  double _gunlukSigaraSayisi = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Adınız ve soyadınız',
              ),
              onChanged: (value) {
                setState(() {
                  _isim = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _cinsiyet,
              hint: Text('Cinsiyetinizi Seçiniz'),
              items: <String>['Erkek', 'Kadın', 'Diğer']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _cinsiyet = newValue;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reşit misiniz?'),
                Switch(
                  value: _resitMi,
                  onChanged: (value) {
                    setState(() {
                      _resitMi = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sigara kullanıyor musunuz?'),
                Switch(
                  value: _sigaraKullaniyorMu,
                  onChanged: (value) {
                    setState(() {
                      _sigaraKullaniyorMu = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (_sigaraKullaniyorMu)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Günde kaç tane sigara kullanıyorsunuz?'),
                  Slider(
                    value: _gunlukSigaraSayisi,
                    min: 0,
                    max: 40,
                    divisions: 40,
                    label: _gunlukSigaraSayisi.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _gunlukSigaraSayisi = value;
                      });
                    },
                  ),
                ],
              ),
            SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Formu gonder
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Bilgiler gönderildi')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: Text('Bilgileri gönder'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
