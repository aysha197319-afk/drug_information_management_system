import 'package:flutter/material.dart';

class PharmacyDetailsScreen extends StatefulWidget {
  const PharmacyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyDetailsScreen> createState() => _PharmacyDetailsScreenState();
}

class _PharmacyDetailsScreenState extends State<PharmacyDetailsScreen> {
  // --- READ: Initial Pharmacy Data ---
  String pharmacyName = "Dhanmondi Health Pharmacy";
  String status = "Open now";
  String openHours = "8:00 AM–10:00 PM · Daily";
  String address = "House 19, Road 8, Dhanmondi, Dhaka 1205 · 0.4 km away";

  // --- READ: Dynamic Medicine Stock List Data ---
  List<Map<String, String>> stockItems = [
    {
      "name": "Napa 500 mg",
      "generic": "Paracetamol · Tablet",
      "pack": "24 strips · 10 tablets / strip",
      "status": "In stock",
    },
    {
      "name": "Alatrol 10 mg",
      "generic": "Cetirizine · Tablet",
      "pack": "12 strips · 10 tablets / strip",
      "status": "In stock",
    },
    {
      "name": "Seclo 20 mg",
      "generic": "Omeprazole · Capsule",
      "pack": "2 strips · 10 capsules / strip",
      "status": "Limited",
    },
    {
      "name": "Ceevit 250 mg",
      "generic": "Ascorbic acid · Tablet",
      "pack": "No stock reported",
      "status": "Unavailable",
    },
  ];

  // --- UPDATE: Edit Pharmacy Info Dialog ---
  void _showEditPharmacyDialog() {
    TextEditingController nameCtrl = TextEditingController(text: pharmacyName);
    TextEditingController statusCtrl = TextEditingController(text: status);
    TextEditingController hoursCtrl = TextEditingController(text: openHours);
    TextEditingController addressCtrl = TextEditingController(text: address);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Edit Pharmacy Info", style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Pharmacy Name")),
                TextField(controller: statusCtrl, decoration: const InputDecoration(labelText: "Status (e.g. Open now)")),
                TextField(controller: hoursCtrl, decoration: const InputDecoration(labelText: "Opening Hours")),
                TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: "Address & Distance")),
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
                setState(() {
                  pharmacyName = nameCtrl.text;
                  status = statusCtrl.text;
                  openHours = hoursCtrl.text;
                  address = addressCtrl.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pharmacy info updated!"), backgroundColor: Color(0xFF00796B)),
                );
              },
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // --- CREATE & UPDATE: Add or Edit Stock Dialog ---
  void _showStockDialog({int? index}) {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController genericCtrl = TextEditingController();
    TextEditingController packCtrl = TextEditingController();
    TextEditingController statusCtrl = TextEditingController();

    bool isEdit = index != null;

    if (isEdit) {
      nameCtrl.text = stockItems[index]["name"]!;
      genericCtrl.text = stockItems[index]["generic"]!;
      packCtrl.text = stockItems[index]["pack"]!;
      statusCtrl.text = stockItems[index]["status"]!;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isEdit ? "Edit Stock Item" : "Add New Medicine Stock",
            style: const TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Medicine Name & Power")),
                TextField(controller: genericCtrl, decoration: const InputDecoration(labelText: "Generic & Form")),
                TextField(controller: packCtrl, decoration: const InputDecoration(labelText: "Quantity/Strips Info")),
                TextField(controller: statusCtrl, decoration: const InputDecoration(labelText: "Status (In stock / Limited / Unavailable)")),
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
                      stockItems[index] = {
                        "name": nameCtrl.text,
                        "generic": genericCtrl.text,
                        "pack": packCtrl.text,
                        "status": statusCtrl.text.isEmpty ? "In stock" : statusCtrl.text,
                      };
                    } else {
                      // CREATE
                      stockItems.add({
                        "name": nameCtrl.text,
                        "generic": genericCtrl.text,
                        "pack": packCtrl.text,
                        "status": statusCtrl.text.isEmpty ? "In stock" : statusCtrl.text,
                      });
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEdit ? "Stock updated!" : "Medicine stock added!"),
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

  // --- DELETE: Remove Stock Item ---
  void _deleteStockItem(int index) {
    setState(() {
      stockItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item removed from stock!"), backgroundColor: Colors.red),
    );
  }

  // --- DELETE: Delete Entire Pharmacy ---
  void _confirmDeletePharmacy() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Delete Pharmacy?", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          content: const Text("Are you sure you want to remove this pharmacy entry completely?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to Pharmacy Screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pharmacy deleted from records!"), backgroundColor: Colors.red),
                );
              },
              child: const Text("Delete", style: TextStyle(color: Colors.white)),
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
              // Top Back & Actions Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back, color: Color(0xFF00796B), size: 18),
                        SizedBox(width: 6),
                        Text(
                          "Pharmacy",
                          style: TextStyle(
                            color: Color(0xFF00796B),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                        onPressed: _showEditPharmacyDialog,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: _confirmDeletePharmacy,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title
              const Text(
                "Pharmacy details",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 16),

              // Image Banner Card
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade300,
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1586015555751-63bb77f4322a?q=80&w=800&auto=format&fit=crop',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "Illustrative pharmacy",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Pharmacy Name
              Text(
                pharmacyName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 8),

              // Status and Hours Row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Color(0xFF00796B),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    openHours,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Address Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_outlined, color: Color(0xFF00796B), size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      address,
                      style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Action Buttons Row (Call & Directions)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00796B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.phone_outlined, size: 18, color: Colors.white),
                        label: const Text(
                          "Call pharmacy",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.near_me_outlined, size: 18, color: Color(0xFF00796B)),
                        label: const Text(
                          "Directions",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF00796B)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Medicine Availability Header (With CREATE Button)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Medicine availability",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                  ),
                  GestureDetector(
                    onTap: () => _showStockDialog(),
                    child: const Text(
                      "+ Add Stock",
                      style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Search Bar inside Pharmacy
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey, size: 20),
                    hintText: "Search this pharmacy's stock",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Dynamic Medicine Stock List (READ, UPDATE, DELETE)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stockItems.length,
                itemBuilder: (context, index) {
                  final item = stockItems[index];
                  String itemStatus = item["status"]!;

                  Color statusBg = const Color(0xFFE8F5E9);
                  Color statusFg = const Color(0xFF00796B);

                  if (itemStatus == "Limited") {
                    statusBg = const Color(0xFFFFF3E0);
                    statusFg = const Color(0xFFE65100);
                  } else if (itemStatus == "Unavailable") {
                    statusBg = Colors.grey.shade200;
                    statusFg = Colors.grey.shade700;
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item["name"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF004D40))),
                              const SizedBox(height: 2),
                              Text(item["generic"]!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                              const SizedBox(height: 2),
                              Text(item["pack"]!, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(6)),
                              child: Text(itemStatus, style: TextStyle(color: statusFg, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, color: Colors.blue, size: 18),
                              onPressed: () => _showStockDialog(index: index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                              onPressed: () => _deleteStockItem(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Disclaimer Footer
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Fictional pharmacy and inventory. Stock counts are not live, and no medicine reservation has been made.",
                  style: TextStyle(fontSize: 9, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}