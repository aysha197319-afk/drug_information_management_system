import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- READ: Sample Dynamic Popular Medicines Data ---
  List<Map<String, String>> popularMedicines = [
    {"name": "Napa", "details": "Paracetamol · 500 mg", "tag": "Pain & fever"},
    {"name": "Seclo", "details": "Omeprazole · 20 mg", "tag": "Digestive health"},
  ];

  // --- READ: Sample Next Reminder State ---
  String reminderTitle = "Your next reminder";
  String reminderTime = "8:00 PM · Check your evening schedule";

  // --- CREATE & UPDATE: Add or Edit Medicine Dialog ---
  void _showMedicineDialog({int? index}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailsController = TextEditingController();
    TextEditingController tagController = TextEditingController();

    bool isEdit = index != null;

    if (isEdit) {
      nameController.text = popularMedicines[index]["name"]!;
      detailsController.text = popularMedicines[index]["details"]!;
      tagController.text = popularMedicines[index]["tag"]!;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isEdit ? "Edit Popular Medicine" : "Add Popular Medicine",
            style: const TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Medicine Name (e.g. Ace)"),
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
                      // UPDATE
                      popularMedicines[index] = {
                        "name": nameController.text,
                        "details": detailsController.text,
                        "tag": tagController.text,
                      };
                    } else {
                      // CREATE
                      popularMedicines.add({
                        "name": nameController.text,
                        "details": detailsController.text,
                        "tag": tagController.text,
                      });
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEdit ? "Medicine updated!" : "New medicine added to Home!"),
                      backgroundColor: const Color(0xFF00796B),
                    ),
                  );
                }
              },
              child: Text(isEdit ? "Save" : "Add", style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // --- DELETE: Remove Medicine ---
  void _deleteMedicine(int index) {
    setState(() {
      popularMedicines.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Medicine removed from Home!"), backgroundColor: Colors.red),
    );
  }

  // --- UPDATE: Edit Reminder Dialog ---
  void _showEditReminderDialog() {
    TextEditingController timeController = TextEditingController(text: reminderTime);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Update Reminder", style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: TextField(
            controller: timeController,
            decoration: const InputDecoration(labelText: "Reminder Schedule"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
              onPressed: () {
                setState(() {
                  reminderTime = timeController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Reminder time updated!"), backgroundColor: Color(0xFF00796B)),
                );
              },
              child: const Text("Update", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
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
              // Top Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search medicines or generics",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Green Promo Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF004D40),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "KNOW YOUR MEDICINE",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Better information.\nMore confident care.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Explore medicine facts and keep your care organized in one place.",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/drugs'),
                      child: Row(
                        children: const [
                          Text(
                            "Explore the drug guide",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Access Title
              const Text(
                "Quick access",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 12),

              // Quick Access Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAccessCard(Icons.access_time, "Reminders", _showEditReminderDialog),
                  _buildQuickAccessCard(Icons.description_outlined, "Prescriptions", () => Navigator.pushNamed(context, '/patient')),
                  _buildQuickAccessCard(Icons.local_pharmacy_outlined, "Pharmacies", () => Navigator.pushNamed(context, '/pharmacy')),
                ],
              ),
              const SizedBox(height: 16),

              // Next Reminder Banner (Interactive Update)
              GestureDetector(
                onTap: _showEditReminderDialog,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_active_outlined, color: Color(0xFF00796B)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reminderTitle,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFF004D40),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              reminderTime,
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.edit_outlined, color: Color(0xFF00796B), size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Popular Medicines Header (With CREATE Button)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular medicines",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showMedicineDialog(),
                        child: const Text(
                          "+ Add",
                          style: TextStyle(
                            color: Color(0xFF00796B),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/drugs'),
                        child: const Text(
                          "View all",
                          style: TextStyle(
                            color: Color(0xFF00796B),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dynamic Popular Medicines List (READ, UPDATE, DELETE)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: popularMedicines.length,
                itemBuilder: (context, index) {
                  final med = popularMedicines[index];
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
                          child: const Icon(Icons.medication, color: Color(0xFF00796B)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(med["name"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF004D40))),
                              const SizedBox(height: 2),
                              Text(med["details"]!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                              const SizedBox(height: 4),
                              Text(med["tag"]!, style: const TextStyle(color: Color(0xFF00796B), fontSize: 11, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        // EDIT (UPDATE)
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.blue, size: 18),
                          onPressed: () => _showMedicineDialog(index: index),
                        ),
                        // DELETE
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                          onPressed: () => _deleteMedicine(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Browse categories Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Browse categories",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40),
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      color: Color(0xFF00796B),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Categories Grid
              Row(
                children: [
                  Expanded(child: _buildCategoryCard(Icons.thermostat, "Pain & fever")),
                  const SizedBox(width: 10),
                  Expanded(child: _buildCategoryCard(Icons.favorite_border, "Heart health")),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildCategoryCard(Icons.medication_outlined, "Allergy care")),
                  const SizedBox(width: 10),
                  Expanded(child: _buildCategoryCard(Icons.bolt, "Vitamins")),
                ],
              ),
              const SizedBox(height: 24),

              // Disclaimer
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Educational sample only. Not personal treatment advice.",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF00796B),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/drugs');
          if (index == 2) Navigator.pushNamed(context, '/patient');
          if (index == 3) Navigator.pushNamed(context, '/pharmacy');
          if (index == 4) Navigator.pushNamed(context, '/profile');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.medication), label: "Drugs"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Patient"),
          BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy), label: "Pharmacy"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildQuickAccessCard(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 105,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF00796B)),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF004D40))),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF00796B), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
            ),
          ),
        ],
      ),
    );
  }
}