import 'package:flutter/material.dart';

class DrugDetailsScreen extends StatefulWidget {
  const DrugDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DrugDetailsScreen> createState() => _DrugDetailsScreenState();
}

class _DrugDetailsScreenState extends State<DrugDetailsScreen> {
  // --- READ / INITIAL DATA ---
  String name = "Napa";
  String generic = "Paracetamol · 500 mg";
  String category = "Pain & fever";
  String dosageForm = "Tablet";
  String manufacturer = "Beximco Pharma";
  List<String> notes = [
    "Take after meal if gastric discomfort occurs.",
  ];

  // --- UPDATE: Edit Medicine Info Dialog ---
  void _showEditDialog() {
    TextEditingController nameCtrl = TextEditingController(text: name);
    TextEditingController genericCtrl = TextEditingController(text: generic);
    TextEditingController categoryCtrl = TextEditingController(text: category);
    TextEditingController manuCtrl = TextEditingController(text: manufacturer);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Edit Medicine Info", style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Brand Name")),
                TextField(controller: genericCtrl, decoration: const InputDecoration(labelText: "Generic & Strength")),
                TextField(controller: categoryCtrl, decoration: const InputDecoration(labelText: "Category/Tag")),
                TextField(controller: manuCtrl, decoration: const InputDecoration(labelText: "Manufacturer")),
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
                  name = nameCtrl.text;
                  generic = genericCtrl.text;
                  category = categoryCtrl.text;
                  manufacturer = manuCtrl.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Medicine info updated!")),
                );
              },
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // --- CREATE: Add Custom Note ---
  void _showAddNoteDialog() {
    TextEditingController noteCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Add Care Note", style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: TextField(
            controller: noteCtrl,
            decoration: const InputDecoration(hintText: "Enter dosage instruction or note..."),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
              onPressed: () {
                if (noteCtrl.text.isNotEmpty) {
                  setState(() {
                    notes.add(noteCtrl.text);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add Note", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // --- DELETE: Confirm Delete Medicine ---
  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Delete Medicine?", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          content: const Text("Are you sure you want to remove this medicine from directory?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to Drugs Screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Medicine deleted from directory!")),
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
              // Top Bar (Back, Edit, Delete)
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
                          "Drugs",
                          style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      // UPDATE Button
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                        onPressed: _showEditDialog,
                      ),
                      // DELETE Button
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: _confirmDelete,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title
              const Text(
                "Medicine details",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 16),

              // Medicine Header Card (Dynamic Read)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.medication, color: Color(0xFF00796B), size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                generic,
                                style: const TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  category,
                                  style: const TextStyle(color: Color(0xFF00796B), fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Dosage form", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            const SizedBox(height: 2),
                            Text(dosageForm, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF004D40))),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Manufacturer", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            const SizedBox(height: 2),
                            Text(manufacturer, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF004D40))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Care Notes / User Remarks (Dynamic CRUD List)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Custom Care Notes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                  ),
                  TextButton.icon(
                    onPressed: _showAddNoteDialog,
                    icon: const Icon(Icons.add, size: 16, color: Color(0xFF00796B)),
                    label: const Text("Add Note", style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Notes List (Delete Note Option)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.note_alt_outlined, color: Color(0xFF00796B), size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(notes[index], style: const TextStyle(fontSize: 12, color: Colors.black87)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey, size: 16),
                          onPressed: () {
                            setState(() {
                              notes.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Bottom Button: Find at a pharmacy
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/pharmacy'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on_outlined, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text("Find at a pharmacy", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
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