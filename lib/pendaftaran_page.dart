import 'package:flutter/material.dart';

void main() {
  runApp(const RegistrasiPage());
}

class RegistrasiPage extends StatelessWidget {
  const RegistrasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registrasi',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorSchemeSeed: const Color.fromARGB(255, 90, 90, 90),
      ),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _nikC = TextEditingController();
  final _namaC = TextEditingController();
  final _tglLahirC = TextEditingController();
  final _tempatLahirC = TextEditingController();
  final _noTelpC = TextEditingController();
  final _asalSekolahC = TextEditingController();

  String? _jurusan; // rpl, tkj, bc, anm, gamedev
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nikC.dispose();
    _namaC.dispose();
    _tglLahirC.dispose();
    _tempatLahirC.dispose();
    _noTelpC.dispose();
    _asalSekolahC.dispose();
    super.dispose();
  }

  // ====== UTIL ======
  InputDecoration _pillDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
      filled: true,
      fillColor: const Color(0xFFD9D9D9),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _pillWrapper(Widget child) {
    return Material(
      elevation: 1.2,
      shadowColor: Colors.black12,
      borderRadius: BorderRadius.circular(18),
      child: child,
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 15, now.month, now.day),
      firstDate: DateTime(1970),
      lastDate: now,
      helpText: 'Pilih Tanggal Lahir',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromARGB(255, 235, 37, 37),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _tglLahirC.text =
          "${picked.day.toString().padLeft(2, '0')}-"
          "${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      setState(() {});
    }
  }

  Widget text(
    BuildContext context,
    String data,
    double size, {
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return Text(
      data,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      textAlign: TextAlign.center,
    );
  }

  // ====== SUBMIT LOKAL (tanpa API) ======
  Future<void> _submitLocal() async {
    setState(() => _isSubmitting = true);

    final payload = {
      "nik": _nikC.text.trim(),
      "nama": _namaC.text.trim(),
      "tanggal_lahir": _tglLahirC.text.trim(), // format dd-MM-yyyy
      "tempat_lahir": _tempatLahirC.text.trim(),
      "no_telp": _noTelpC.text.trim(),
      "asal_sekolah": _asalSekolahC.text.trim(),
      "jurusan_kode": _jurusan, // 'rpl','tkj','bc','anm','gamedev'
    };

    // simulasi proses singkat
    await Future<void>.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form valid. (Tanpa kirim ke server)')),
    );

    // optional: reset form
    _formKey.currentState?.reset();
    _nikC.clear();
    _namaC.clear();
    _tglLahirC.clear();
    _tempatLahirC.clear();
    _noTelpC.clear();
    _asalSekolahC.clear();
    setState(() {
      _jurusan = null;
      _isSubmitting = false;
    });

    // kalau mau lihat payload di debug console:
    // ignore: avoid_print
    print(payload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 340),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Center(
                        child: text(
                          context,
                          'SMKN GRINGGOS 2',
                          20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      // ====== Panel dengan outline ======
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 116, 116, 116),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 4),
                              const Text(
                                'Registrasi',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 18),

                              // NIK
                              _pillWrapper(
                                TextFormField(
                                  controller: _nikC,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: _pillDecoration('NIK'),
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                      ? 'NIK wajib diisi'
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Nama
                              _pillWrapper(
                                TextFormField(
                                  controller: _namaC,
                                  textAlign: TextAlign.center,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: _pillDecoration('Nama'),
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                      ? 'Nama wajib diisi'
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Tanggal Lahir
                              _pillWrapper(
                                TextFormField(
                                  controller: _tglLahirC,
                                  readOnly: true,
                                  onTap: _pickDate,
                                  textAlign: TextAlign.center,
                                  decoration: _pillDecoration('Tanggal Lahir'),
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                      ? 'Tanggal lahir wajib diisi'
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Tempat Lahir
                              _pillWrapper(
                                TextFormField(
                                  controller: _tempatLahirC,
                                  textAlign: TextAlign.center,
                                  decoration: _pillDecoration('Tempat Lahir'),
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                      ? 'Tempat lahir wajib diisi'
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // NoTLP
                              _pillWrapper(
                                TextFormField(
                                  controller: _noTelpC,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.phone,
                                  decoration: _pillDecoration('NoTLP'),
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                      ? 'No telepon wajib diisi'
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Asal SMPN/S/MTS
                              _pillWrapper(
                                TextFormField(
                                  controller: _asalSekolahC,
                                  textAlign: TextAlign.center,
                                  decoration: _pillDecoration(
                                    'Asal SMPN/S/ MTS',
                                  ),
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                      ? 'Asal sekolah wajib diisi'
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Jurusan Dropdown
                              _pillWrapper(
                                DropdownButtonFormField<String>(
                                  value: _jurusan,
                                  isExpanded: true,
                                  decoration: _pillDecoration('Jurusan'),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  alignment: Alignment.center,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'rpl',
                                      child: Center(
                                        child: Text('Rekayasa Perangkat Lunak'),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'tkj',
                                      child: Center(
                                        child: Text('Teknik Komputer Jaringan'),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'bc',
                                      child: Center(
                                        child: Text('Broadcasting'),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'anm',
                                      child: Center(child: Text('Animasi')),
                                    ),
                                    DropdownMenuItem(
                                      value: 'gamedev',
                                      child: Center(
                                        child: Text('Game Development'),
                                      ),
                                    ),
                                  ],
                                  onChanged: (v) =>
                                      setState(() => _jurusan = v),
                                  validator: (v) =>
                                      v == null ? 'Pilih jurusan' : null,
                                  selectedItemBuilder: (context) {
                                    final values = [
                                      'rpl',
                                      'tkj',
                                      'bc',
                                      'anm',
                                      'gamedev',
                                    ];
                                    return values
                                        .map(
                                          (e) => Center(
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList();
                                  },
                                ),
                              ),
                              const SizedBox(height: 22),

                              // Tombol Submit
                              SizedBox(
                                width: 120,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    elevation: 1.5,
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  onPressed: _isSubmitting
                                      ? null
                                      : () {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            _submitLocal();
                                          }
                                        },
                                  child: Text(
                                    _isSubmitting ? 'Loading...' : 'Submit',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
