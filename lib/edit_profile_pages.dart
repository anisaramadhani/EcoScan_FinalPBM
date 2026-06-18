import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profil",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              /// FOTO PROFIL
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://via.placeholder.com/150",
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF436946),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                "Klik untuk mengubah foto profil",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 24),

              /// FORM
              _buildField(
                "Nama Lengkap",
                "Pengguna EcoScan",
              ),

              _buildField(
                "Email",
                "EcoScan@email.com",
              ),

              _buildField(
                "Nomor Telepon",
                "+62 812 3456 7890",
              ),

              _buildField(
                "Bio",
                "Eco enthusiast yang peduli lingkungan",
              ),

              const SizedBox(height: 24),

              /// BUTTON
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Batal"),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF436946),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(16),
                              ),
                              title: const Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 8),
                                  Text("Berhasil"),
                                ],
                              ),
                              content: const Text(
                                "Data profil berhasil diubah.",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );

                        // kembali ke halaman profile
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Simpan Perubahan",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    String initialValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}