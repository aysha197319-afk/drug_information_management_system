import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- READ: User Profile Information State ---
  String name = "Ayesha Rahman";
  String email = "ayesha@example.com";
  String phone = "+880 17XX-XXXXXX";
  String address = "Dhanmondi, Dhaka, Bangladesh";
  String avatarInitials = "AR";

  // --- READ: Dynamic Favorites Data List ---
  List<Map<String, String>> favorites = [
    {"title": "Napa 500 mg", "subtitle": "Paracetamol · Saved medicine", "type": "med"},
    {"title": "Dhanmondi Health Pharmacy", "subtitle": "Saved pharmacy · 0.4 km away", "type": "pharmacy"},
  ];

  // --- READ: Dynamic Notifications Data List ---
  List<Map<String, String>> notifications = [
    {"title": "Follow-up on 10 October", "subtitle": "Your sample care record has a follow-up date. · Today"},
    {"title": "Prescription added", "subtitle": "RX-2026-104 is in your care records. · Yesterday"},
  ];

  // --- UPDATE: Edit Personal Information Dialog ---
  void _showEditProfileDialog() {
    TextEditingController nameCtrl = TextEditingController(text: name);
    TextEditingController emailCtrl = TextEditingController(text: email);
    TextEditingController phoneCtrl = TextEditingController(text: phone);
    TextEditingController addressCtrl = TextEditingController(text: address);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Edit Personal Information", style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Full Name")),
                TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: "Email Address")),
                TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: "Phone Number")),
                TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: "Address")),
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
                    name = nameCtrl.text;
                    email = emailCtrl.text;
                    phone = phoneCtrl.text;
                    address = addressCtrl.text;

                    List<String> words = name.trim().split(" ");
                    if (words.length >= 2) {
                      avatarInitials = "${words[0][0]}${words[1][0]}".toUpperCase();
                    } else if (words.isNotEmpty && words[0].isNotEmpty) {
                      avatarInitials = words[0][0].toUpperCase();
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile information updated!"), backgroundColor: Color(0xFF00796B)),
                  );
                }
              },
              child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // --- CREATE: Add New Favorite Item Dialog ---
  void _showAddFavoriteDialog() {
    TextEditingController titleCtrl = TextEditingController();
    TextEditingController subtitleCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Add Favorite Item", style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: "Item Name (e.g. Ace 500 mg)")),
              TextField(controller: subtitleCtrl, decoration: const InputDecoration(labelText: "Description (e.g. Saved Medicine)")),
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
                if (titleCtrl.text.isNotEmpty) {
                  setState(() {
                    favorites.add({
                      "title": titleCtrl.text,
                      "subtitle": subtitleCtrl.text.isEmpty ? "Saved item" : subtitleCtrl.text,
                      "type": "med",
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Favorite item added!"), backgroundColor: Color(0xFF00796B)),
                  );
                }
              },
              child: const Text("Add", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // --- DELETE: Remove Favorite Item ---
  void _deleteFavorite(int index) {
    setState(() {
      favorites.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Removed from favorites!"), backgroundColor: Colors.red),
    );
  }

  // --- DELETE: Remove Notification Item ---
  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Notification cleared!"), backgroundColor: Colors.red),
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
                    child: const Icon(Icons.more_horiz, color: Colors.grey, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "My profile",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "Your account, saved items and preferences.",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 20),

              // Profile Avatar Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: const Color(0xFFE8F5E9),
                      child: Text(
                        avatarInitials,
                        style: const TextStyle(
                          color: Color(0xFF00796B),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004D40),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Demo account · ML-2040",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Personal Information Section (With UPDATE Edit Button)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Personal information",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                  ),
                  GestureDetector(
                    onTap: _showEditProfileDialog,
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.email_outlined, email),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.phone_outlined, phone),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.location_on_outlined, address),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Favorites Section (With CREATE & DELETE)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Favorites",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                  ),
                  GestureDetector(
                    onTap: _showAddFavoriteDialog,
                    child: const Text(
                      "+ Add",
                      style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: favorites.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No favorite items saved.", style: TextStyle(color: Colors.grey, fontSize: 12)),
                )
                    : Column(
                  children: List.generate(favorites.length, (index) {
                    final item = favorites[index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                item["type"] == "pharmacy" ? Icons.storefront_outlined : Icons.medication_outlined,
                                color: const Color(0xFF00796B),
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF004D40))),
                                  const SizedBox(height: 2),
                                  Text(item["subtitle"]!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                              onPressed: () => _deleteFavorite(index),
                            ),
                          ],
                        ),
                        if (index < favorites.length - 1) const Padding(padding: EdgeInsets.symmetric(vertical: 6.0), child: Divider(height: 1)),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // Notifications Section (With DELETE)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Notifications",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                  ),
                  Text(
                    "${notifications.length} new",
                    style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: notifications.isEmpty
                    ? const Text("No new notifications.", style: TextStyle(color: Colors.grey, fontSize: 12))
                    : Column(
                  children: List.generate(notifications.length, (index) {
                    final notif = notifications[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: index < notifications.length - 1 ? 12.0 : 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.notifications_none, color: Color(0xFF00796B), size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notif["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF004D40))),
                                const SizedBox(height: 2),
                                Text(notif["subtitle"]!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _deleteNotification(index),
                            child: const Icon(Icons.close, color: Colors.grey, size: 16),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // Settings Section
              const Text(
                "Settings",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _buildSettingRow(Icons.notifications_none, "Notification preferences", subtitle: "Medicine reminders & care updates"),
                    const Divider(height: 16),
                    _buildSettingRow(Icons.g_translate_outlined, "Language", trailingText: "English"),
                    const Divider(height: 16),
                    _buildSettingRow(Icons.shield_outlined, "Privacy & security", subtitle: "Manage your data and access"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Help & Support Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.help_outline, color: Color(0xFF00796B), size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Help & Support",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF004D40)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Guidance for using MediLink. Browse FAQs or contact the support team for account and app questions.",
                      style: TextStyle(color: Colors.black87, fontSize: 11, height: 1.3),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text(
                          "Visit the help center",
                          style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, color: Color(0xFF00796B), size: 14),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Log Out Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout, color: Color(0xFF00796B), size: 18),
                  label: const Text(
                    "Log out",
                    style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Profile tab active
        selectedItemColor: const Color(0xFF00796B),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 1) Navigator.pushNamed(context, '/drugs');
          if (index == 2) Navigator.pushNamed(context, '/patient');
          if (index == 3) Navigator.pushNamed(context, '/pharmacy');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.medication_outlined), label: "Drugs"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Patient"),
          BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy_outlined), label: "Pharmacy"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Color(0xFF004D40), fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingRow(IconData icon, String title, {String? subtitle, String? trailingText}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF00796B), size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF004D40))),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ],
          ),
        ),
        if (trailingText != null)
          Text(trailingText, style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(width: 4),
        const Icon(Icons.chevron_right, color: Colors.grey),
      ],
    );
  }
}