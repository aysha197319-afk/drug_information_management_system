import 'package:flutter/material.dart';

class DrugsScreen extends StatefulWidget {
  const DrugsScreen({Key? key}) : super(key: key);

  @override
  State<DrugsScreen> createState() => _DrugsScreenState();
}

class _DrugsScreenState extends State<DrugsScreen> {
  // --- READ: Sample Data List ---
  List<Map<String, String>> medicines = [
    {"name": "Ace", "details": "Paracetamol · 500 mg", "tag": "Pain & fever"},
    {"name": "Alatrol", "details": "Cetirizine · 10 mg", "tag": "Allergy care"},
    {"name": "Ceevit", "details": "Ascorbic acid · 250 mg", "tag": "Vitamins"},
    {"name": "Napa", "details": "Paracetamol · 500 mg", "tag": "Pain & fever"},
    {"name": "Seclo", "details": "Omeprazole · 20 mg", "tag": "Digestive health"},
  ];

  // --- CREATE & UPDATE: Dialog Function ---
  void _showMedicineDialog({int? index}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailsController = TextEditingController();
    TextEditingController tagController = TextEditingController();

    bool isEdit = index != null;

    if (isEdit) {
      nameController.text = medicines[index]["name"]!;
      detailsController.text = medicines[index]["details"]!;
      tagController.text = medicines[index]["tag"]!;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(isEdit ? "Edit Medicine" : "Add New Medicine",
              style: const TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Medicine Name (e.g. Napa)"),
              ),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(labelText: "Details (e.g. Paracetamol · 500 mg)"),
              ),
              TextField(
                controller: tagController,
                decoration: const InputDecoration(labelText: "Category/Tag (e.g. Pain & fever)"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    if (isEdit) {
                      // UPDATE Operation
                      medicines[index] = {
                        "name": nameController.text,
                        "details": detailsController.text,
                        "tag": tagController.text,
                      };
                    } else {
                      // CREATE Operation
                      medicines.add({
                        "name": nameController.text,
                        "details": detailsController.text,
                        "tag": tagController.text,
                      });
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(isEdit ? "Save Changes" : "Add", style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // --- DELETE Operation ---
  void _deleteMedicine(int index) {
    setState(() {
      medicines.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Medicine deleted successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.add_circle, color: Color(0xFF00796B), size: 18),
                      SizedBox(width: 6),
                      Text(
                        "MEDILINK",
                        style: TextStyle(
                          color: Color(0xFF00796B),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.favorite_border, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "Drug directory",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Manage, add, edit & delete medicine entries.",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),

              // Dynamic Medicine List Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Medicine list",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                  ),
                  Text(
                    "${medicines.length} results",
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dynamic Medicine List (READ, UPDATE, DELETE)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final med = medicines[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.medication, color: Color(0xFF00796B), size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(med["name"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF004D40))),
                              const SizedBox(height: 2),
                              Text(med["details"]!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                              const SizedBox(height: 4),
                              Text(med["tag"]!, style: const TextStyle(color: Color(0xFF00796B), fontSize: 10, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        // Edit Icon (UPDATE)
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.blue, size: 20),
                          onPressed: () => _showMedicineDialog(index: index),
                        ),
                        // Delete Icon (DELETE)
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                          onPressed: () => _deleteMedicine(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button (CREATE - Add New Medicine)
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00796B),
        onPressed: () => _showMedicineDialog(),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Drug", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF00796B),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 2) Navigator.pushNamed(context, '/patient');
          if (index == 3) Navigator.pushNamed(context, '/pharmacy');
          if (index == 4) Navigator.pushNamed(context, '/profile');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.medication), label: "Drugs"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Patient"),
          BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy_outlined), label: "Pharmacy"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}