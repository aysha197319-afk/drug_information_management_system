import 'package:flutter/material.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  // --- READ: Patient Info State ---
  String patientName = "Ayesha Rahman";
  String patientAgeGender = "32 years · Female · Dhaka";
  String bloodGroup = "O+";
  String patientId = "ML-2040";

  // --- READ: Dynamic Medicines List Data ---
  List<Map<String, String>> myMedicines = [
    {
      "name": "Alatrol 10 mg",
      "details": "Cetirizine · Evening schedule from sample Rx",
      "badge": "Scheduled",
      "reminder": "Next reminder · Today, 8:00 PM"
    },
    {
      "name": "Napa 500 mg",
      "details": "Paracetamol · Follow the recorded prescription. No fixed reminder.",
      "badge": "As needed",
      "reminder": ""
    },
  ];

  // --- CREATE & UPDATE: Add / Edit Medicine Dialog ---
  void _showMedicineDialog({int? index}) {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController detailsCtrl = TextEditingController();
    TextEditingController badgeCtrl = TextEditingController();
    TextEditingController reminderCtrl = TextEditingController();

    bool isEdit = index != null;

    if (isEdit) {
      nameCtrl.text = myMedicines[index]["name"]!;
      detailsCtrl.text = myMedicines[index]["details"]!;
      badgeCtrl.text = myMedicines[index]["badge"]!;
      reminderCtrl.text = myMedicines[index]["reminder"]!;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isEdit ? "Edit Medicine Record" : "Add New Medicine",
            style: const TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Medicine Name & Dose (e.g. Napa 500 mg)"),
                ),
                TextField(
                  controller: detailsCtrl,
                  decoration: const InputDecoration(labelText: "Instructions/Details"),
                ),
                TextField(
                  controller: badgeCtrl,
                  decoration: const InputDecoration(labelText: "Status (e.g. Scheduled / As needed)"),
                ),
                TextField(
                  controller: reminderCtrl,
                  decoration: const InputDecoration(labelText: "Reminder (e.g. Next reminder · Today, 8:00 PM)"),
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
                      // UPDATE Operation
                      myMedicines[index] = {
                        "name": nameCtrl.text,
                        "details": detailsCtrl.text,
                        "badge": badgeCtrl.text.isEmpty ? "Scheduled" : badgeCtrl.text,
                        "reminder": reminderCtrl.text,
                      };
                    } else {
                      // CREATE Operation
                      myMedicines.add({
                        "name": nameCtrl.text,
                        "details": detailsCtrl.text,
                        "badge": badgeCtrl.text.isEmpty ? "Scheduled" : badgeCtrl.text,
                        "reminder": reminderCtrl.text,
                      });
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEdit ? "Medicine updated!" : "New medicine added to My Care!"),
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

  // --- DELETE: Remove Medicine Record ---
  void _deleteMedicine(int index) {
    setState(() {
      myMedicines.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Medicine removed from care records!"), backgroundColor: Colors.red),
    );
  }

  // --- UPDATE: Edit Patient Profile Dialog ---
  void _showEditProfileDialog() {
    TextEditingController nameCtrl = TextEditingController(text: patientName);
    TextEditingController ageCtrl = TextEditingController(text: patientAgeGender);
    TextEditingController bloodCtrl = TextEditingController(text: bloodGroup);
    TextEditingController idCtrl = TextEditingController(text: patientId);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Edit Patient Profile", style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Full Name")),
                TextField(controller: ageCtrl, decoration: const InputDecoration(labelText: "Age & Info")),
                TextField(controller: bloodCtrl, decoration: const InputDecoration(labelText: "Blood Group")),
                TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "Patient ID")),
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
                  patientName = nameCtrl.text;
                  patientAgeGender = ageCtrl.text;
                  bloodGroup = bloodCtrl.text;
                  patientId = idCtrl.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Patient profile updated!"), backgroundColor: Color(0xFF00796B)),
                );
              },
              child: const Text("Update Profile", style: TextStyle(color: Colors.white)),
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
                "My care",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Your medicines and health records, together.",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),

              // Patient Profile Card (UPDATE profile)
              GestureDetector(
                onTap: _showEditProfileDialog,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xFFE8F5E9),
                            child: const Text(
                              "AR",
                              style: TextStyle(
                                color: Color(0xFF00796B),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      patientName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF004D40),
                                      ),
                                    ),
                                    const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF00796B)),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  patientAgeGender,
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    "Sample patient",
                                    style: TextStyle(fontSize: 10, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPatientInfoTile("Blood group", bloodGroup),
                          _buildPatientInfoTile("Patient ID", patientId),
                          _buildPatientInfoTile("Allergies", "Not recorded"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // My Medicines Section Header (With CREATE Button)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My medicines",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showMedicineDialog(),
                    child: const Text(
                      "+ Add Medicine",
                      style: TextStyle(color: Color(0xFF00796B), fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dynamic Medicine List (READ, UPDATE, DELETE)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myMedicines.length,
                itemBuilder: (context, index) {
                  final med = myMedicines[index];
                  bool isScheduled = med["badge"] == "Scheduled";
                  return Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(med["name"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF004D40))),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: isScheduled ? const Color(0xFFE8F5E9) : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    med["badge"]!,
                                    style: TextStyle(
                                      color: isScheduled ? const Color(0xFF00796B) : Colors.grey.shade700,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                          ],
                        ),
                        Text(med["details"]!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                        if (med["reminder"] != null && med["reminder"]!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 14, color: Color(0xFF00796B)),
                              const SizedBox(width: 6),
                              Text(med["reminder"]!, style: const TextStyle(color: Color(0xFF00796B), fontSize: 11, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ]
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Medicine Reminders Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_active_outlined, color: Color(0xFF00796B)),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Medicine reminders",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF004D40),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "1 active schedule · Asia/Dhaka",
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Manage",
                      style: TextStyle(
                        color: const Color(0xFF00796B),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right, color: Color(0xFF00796B), size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Prescriptions Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Prescriptions",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40),
                    ),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(color: Color(0xFF00796B), fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Prescription Card
              Container(
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
                          child: const Icon(Icons.description_outlined, color: Color(0xFF00796B), size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Dr. Farhana Ahmed",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF004D40)),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "General practitioner · Sample record",
                                style: TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "05 Oct 2026 · 2 medicines",
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Latest",
                            style: TextStyle(color: Color(0xFF00796B), fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                  "Personal patient and care records. Schedules shown here illustrate the design, not treatment advice.",
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
        currentIndex: 2, // Patient tab active
        selectedItemColor: const Color(0xFF00796B),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 1) Navigator.pushNamed(context, '/drugs');
          if (index == 3) Navigator.pushNamed(context, '/pharmacy');
          if (index == 4) Navigator.pushNamed(context, '/profile');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.medication_outlined), label: "Drugs"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Patient"),
          BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy_outlined), label: "Pharmacy"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildPatientInfoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF004D40))),
      ],
    );
  }
}