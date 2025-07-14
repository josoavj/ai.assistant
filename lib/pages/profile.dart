import 'package:ai_test/others/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.back)
        ),
        title: Text(
          "Mon compte",
          style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                _showLogoutDialog(context);
              }
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Section Photo de profil et informations de base
            _buildProfileHeader(),
            const SizedBox(height: 24),

            // Section Informations personnelles
            _buildPersonalInfoSection(),
            const SizedBox(height: 24),

            // Section Paramètres
            _buildSettingsSection(),
            const SizedBox(height: 24),

            // Section Actions
            _buildActionsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    CupertinoIcons.person_fill,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(CupertinoIcons.camera_fill,
                          color: Colors.white, size: 16),
                      onPressed: () {
                        // Logique pour changer la photo de profil
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "sudoted",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "En ligne",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informations personnelles",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow("Email", "sudoted@example.com", CupertinoIcons.mail_solid),
            const SizedBox(height: 12),
            _buildInfoRow("Téléphone", "+261 34 12 345 67", CupertinoIcons.phone_fill),
            const SizedBox(height: 12),
            _buildInfoRow("Localisation", "Antananarivo, Madagascar", CupertinoIcons.location_solid),
            const SizedBox(height: 12),
            _buildInfoRow("Membre depuis", "Janvier 2024", CupertinoIcons.calendar),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.pencil, size: 16),
          onPressed: () {
            // Logique pour modifier les informations
          },
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Paramètres",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingRow(
              "Notifications",
              CupertinoIcons.bell_fill,
              Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            _buildSettingRow(
              "Mode sombre",
              CupertinoIcons.moon_fill,
              Switch(
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(String title, IconData icon, Widget trailing) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        trailing,
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Actions",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildActionRow("Changer le mot de passe", CupertinoIcons.lock_fill, () {
              // Logique pour changer le mot de passe
            }),
            const SizedBox(height: 12),
            _buildActionRow("Historique des activités", CupertinoIcons.time, () {
              // Logique pour voir l'historique
            }),
            const SizedBox(height: 12),
            _buildActionRow("Aide et support", CupertinoIcons.question_circle_fill, () {
              // Logique pour l'aide
            }),
            const SizedBox(height: 12),
            _buildActionRow("Politique de confidentialité", CupertinoIcons.doc_text_fill, () {
              // Logique pour la politique de confidentialité
            }),
            const SizedBox(height: 12),
            _buildActionRow("Supprimer le compte", CupertinoIcons.delete_solid, () {
              _showDeleteAccountDialog(context);
            }, isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildActionRow(String title, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
                icon,
                size: 20,
                color: isDestructive ? Colors.red : Colors.grey[600]
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? Colors.red : null,
                ),
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Déconnexion",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          content: Text(
            "Êtes-vous sûr de vouloir vous déconnecter?",
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          actions: [
            TextButton(
              child: Text(
                "Annuler",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Déconnecter",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Remplacez MyAI() par votre page de connexion
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyAI()));
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Supprimer le compte",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          content: Text(
            "Cette action est irréversible. Toutes vos données seront définitivement supprimées.",
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          actions: [
            TextButton(
              child: Text(
                "Annuler",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Supprimer",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Logique pour supprimer le compte
              },
            ),
          ],
        );
      },
    );
  }
}