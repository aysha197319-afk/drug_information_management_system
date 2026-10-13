import 'package:flutter/material.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  // --- READ: Dynamic Pharmacy List Data ---
  List<Map<String, String>> pharmacies = [
    {
      "name": "Dhanmondi Health Pharmacy",
      "address": "Road 8, Dhanmondi · 0.4 km",
      "status": "Open now",
      "timeInfo": "Closes 10:00 PM",
      "stockInfo": "Napa 500 mg · In stock",
    },
    {
      "name": "Lakeview Medicine Corner",
      "address": "Road 12, Dhanmondi · 0.8 km",
      "status": "Open now",
      "timeInfo": "Closes 10:00 PM",
      "stockInfo": "Napa 500 mg · Limited stock",
    },
    {
      "name": "Green Road Pharmacy",
      "address": "Green Road, Dhaka · 1.2 km",
      "status": "Closed",
      "timeInfo": "Opens tomorrow 8:00 AM",
      "stockInfo": "Napa 500 mg · Not available",
    },
  ];

  // --- CREATE & UPDATE: Add or Edit Pharmacy Dialog ---
  void _showPharmacyDialog({int? index}) {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController addressCtrl = TextEditingController();
    TextEditingController statusCtrl = TextEditingController();
    TextEditingController timeCtrl = TextEditingController();
    TextEditingController stockCtrl = TextEditingController();

    bool isEdit = index != null;

    if (isEdit) {
      nameCtrl.text = pharmacies[index]["name"]!;
      addressCtrl.text = pharmacies[index]["address"]!;
      statusCtrl.text = pharmacies[index]["status"]!;
      timeCtrl.text = pharmacies[index]["timeInfo"]!;
      stockCtrl.text = pharmacies[index]["stockInfo"]!;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isEdit ? "Edit Pharmacy Record" : "Add New Pharmacy",
            style: const TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Pharmacy Name"),
                ),
                TextField(
                  controller: addressCtrl,
                  decoration: const InputDecoration(labelText: "Address & Distance"),
                ),
                TextField(
                  controller: statusCtrl,
                  decoration: const InputDecoration(labelText: "Status (e.g. Open now / Closed)"),
                ),
                TextField(
                  controller: timeCtrl,
                  decoration: const InputDecoration(labelText: "Timing Info (e.g. Closes 10:00 PM)"),
                ),
                TextField(
                  controller: stockCtrl,
                  decoration: const InputDecoration(labelText: "Stock Availability Info"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
              onPressed: () {
                if (nameCtrl.text.isNotEmpty) {
                  setState(() {
                    if (isEdit) {
                      // UPDATE
                      pharmacies[index] = {
                        "name": nameCtrl.text,
                        "address": addressCtrl.text,
                        "status": statusCtrl.text.isEmpty ? "Open now" : statusCtrl.text,
                        "timeInfo": timeCtrl.text,
                        "stockInfo": stockCtrl.text,
                      };
                    } else {
                      // CREATE
                      pharmacies.add({
                        "name": nameCtrl.text,
                        "address": addressCtrl.text,
                        "status": statusCtrl.text.isEmpty ? "Open now" : statusCtrl.text,
                        "timeInfo": timeCtrl.text,
                        "stockInfo": stockCtrl.text,
                      });
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEdit ? "Pharmacy updated!" : "New pharmacy added!"),
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

  // --- DELETE: Remove Pharmacy ---
  void _deletePharmacy(int index) {
    setState(() {
      pharmacies.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pharmacy removed from list!"), backgroundColor: Colors.red),
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
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(Icons.notifications_none, color: Colors.grey, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "Find a pharmacy",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "Explore nearby options in Dhaka.",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 12),

              // Location Selector Row
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Color(0xFF00796B), size: 18),
                  const SizedBox(width: 6),
                  const Text(
                    "Dhanmondi, Dhaka",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF004D40)),
                  ),
                  const Spacer(),
                  Text(
                    "Change",
                    style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Search Bar
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
                    hintText: "Search pharmacy or area",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Map Preview Box
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text("Illustrative map", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ),
                    ),
                    Center(
                      child: Icon(Icons.map_outlined, size: 48, color: const Color(0xFF00796B).withOpacity(0.3)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Nearby Pharmacies Header (With CREATE Button)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Nearby pharmacies",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showPharmacyDialog(),
                        child: const Text(
                          "+ Add Pharmacy",
                          style: TextStyle(color: Color(0xFF00796B), fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${pharmacies.length} results",
                        style: const TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dynamic Pharmacies List (READ, UPDATE, DELETE)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pharmacies.length,
                itemBuilder: (context, index) {
                  final pharm = pharmacies[index];
                  bool isOpen = pharm["status"] == "Open now";

                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/pharmacy-details'),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.local_pharmacy, color: Color(0xFF00796B), size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pharm["name"]!,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF004D40)),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(pharm["address"]!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                  ],
                                ),
                              ),
                              // EDIT (UPDATE)
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: Colors.blue, size: 18),
                                onPressed: () => _showPharmacyDialog(index: index),
                              ),
                              // DELETE
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                                onPressed: () => _deletePharmacy(index),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isOpen ? const Color(0xFFE8F5E9) : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  pharm["status"]!,
                                  style: TextStyle(
                                    color: isOpen ? const Color(0xFF00796B) : Colors.grey.shade700,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(pharm["timeInfo"]!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.medication_outlined, size: 13, color: Color(0xFF00796B)),
                              const SizedBox(width: 6),
                              Text(
                                pharm["stockInfo"]!,
                                style: const TextStyle(color: Color(0xFF00796B), fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Disclaimer Footer
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Fictional pharmacies and stock. Availability can change; contact the pharmacy before visiting.",
                  style: TextStyle(fontSize: 9, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Pharmacy tab active
        selectedItemColor: const Color(0xFF00796B),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 1) Navigator.pushNamed(context, '/drugs');
          if (index == 2) Navigator.pushNamed(context, '/patient');
          if (index == 4) Navigator.pushNamed(context, '/profile');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.medication_outlined), label: "Drugs"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Patient"),
          BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy), label: "Pharmacy"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}