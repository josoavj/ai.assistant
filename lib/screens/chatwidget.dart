import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_fonts/google_fonts.dart'; // Import pour des polices cohérentes

class ChatWidget extends StatefulWidget {
  const ChatWidget({required this.apiKey, super.key});

  final String apiKey;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late ChatSession _chat; // Rendu non-final pour pouvoir être réinitialisé si nécessaire
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode(debugLabel: 'TextField');
  bool _loading = false;

  // --- CORRECTION CLÉ : Maintenir notre propre liste de messages pour l'affichage ---
  final List<Content> _messages = []; // Cette liste contiendra l'historique du chat pour l'affichage

  // Paramètres de sécurité (déjà bons, conservés pour le contexte)
  final safetySettings = [
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.low),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.low),
  ];

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: widget.apiKey,
      safetySettings: safetySettings, // Appliquer les paramètres de sécurité
    );
    // --- CORRECTION CLÉ : Initialiser la session de chat avec notre liste d'historique modifiable ---
    _chat = _model.startChat(history: _messages); // Passer notre liste _messages ici
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _textFieldFocus.dispose();
    super.dispose();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 300, // Défilement plus rapide pour une sensation plus vive
        ),
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- CORRECTION CLÉ : Utiliser notre propre liste _messages pour l'affichage ---
    final historyToDisplay = _messages; // Maintenant, nous utilisons notre liste modifiable pour l'affichage

    // Ajouter un arrière-plan légèrement teinté à la zone de chat
    return Container(
      color: Colors.blueGrey[50], // Arrière-plan clair pour la zone des bulles de chat
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0), // Rembourrage autour des messages
              // --- CORRECTION CLÉ : Utiliser notre propre liste _messages pour itemCount et itemBuilder ---
              itemBuilder: (context, idx) {
                final content = historyToDisplay[idx]; // Utiliser notre liste
                final text = content.parts
                    .whereType<TextPart>()
                    .map<String>((e) => e.text)
                    .join('');
                return MessageBubble( // Utilisation de MessageBubble maintenant
                  text: text,
                  isFromUser: content.role == 'user',
                );
              },
              itemCount: historyToDisplay.length, // Utiliser la longueur de notre liste
              // --- FIN DE LA CORRECTION ---
            ),
          ),
          // Zone de saisie
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      color: theme.scaffoldBackgroundColor, // Utiliser l'arrière-plan du scaffold pour la cohérence
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              focusNode: _textFieldFocus,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences, // Mettre en majuscule la première lettre des phrases
              decoration: _buildTextFieldDecoration(context, 'Tapez votre message ici...'), // Appel corrigé
              onSubmitted: (String value) {
                _sendChatMessage(value);
              },
              maxLines: 5, // Autoriser plusieurs lignes
              minLines: 1,
              keyboardType: TextInputType.multiline,
              style: GoogleFonts.poppins(fontSize: 16), // Style de police pour le texte de saisie
            ),
          ),
          const SizedBox(width: 10),
          _loading
              ? Padding(
            padding: const EdgeInsets.all(8.0), // Rembourrage pour l'indicateur de chargement
            child: CircularProgressIndicator(
              color: theme.primaryColor, // Utiliser la couleur principale pour l'indicateur
            ),
          )
              : Container( // Envelopper IconButton dans un Container pour un bouton stylisé
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(30.0), // Bouton entièrement arrondi
            ),
            child: IconButton(
              onPressed: () {
                _sendChatMessage(_textController.text);
              },
              icon: const Icon(Icons.send_rounded, color: Colors.white), // Icône d'envoi arrondie
              tooltip: 'Envoyer le message',
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildTextFieldDecoration(BuildContext context, String hintText) {
    final theme = Theme.of(context);
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 16),
      filled: true,
      fillColor: Colors.grey[200], // Arrière-plan gris clair pour le champ de texte
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0), // Coins arrondis pour le champ de saisie
        borderSide: BorderSide.none, // Pas de ligne de bordure
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: theme.primaryColor, width: 2.0), // Bordure de couleur principale lorsqu'il est en focus
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Ajuster le rembourrage à l'intérieur du champ de texte
    );
  }

  Future<void> _sendChatMessage(String message) async {
    if (message.trim().isEmpty) return;

    final userMessage = Content.text(message);
    setState(() {
      _loading = true;
      _messages.add(userMessage);
    });
    _textController.clear();
    _scrollDown();

    try {
      final response = await _chat.sendMessage(userMessage);

      // --- FIX START: Accessing AI response content correctly ---
      if (response.candidates.isNotEmpty) {
        final aiResponseContent = response.candidates.first.content;
        if (aiResponseContent != null) {
          setState(() {
            _messages.add(aiResponseContent);
          });
        } else {
          _showError('Réponse de l\'IA vide ou invalide.');
        }
      } else {
        _showError('Aucune réponse valide de l\'IA reçue.');
      }
      // --- FIX END ---

    } catch (e) {
      _showError('Erreur: ${e.toString()}');
    } finally {
      setState(() {
        _loading = false;
      });
      _scrollDown();
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erreur d\'exécution', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Text(message, style: GoogleFonts.poppins()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: GoogleFonts.poppins(color: Theme.of(context).primaryColor)),
            )
          ],
        );
      },
    );
  }
}

// --- Nouveau MessageBubble (anciennement MessageWidget) ---
// Cette classe devrait être définie dans le même fichier ou dans 'package:ai_test/others/screenswidget.dart'
// et son code doit être mis à jour pour correspondre à cette version améliorée.
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.text,
    required this.isFromUser,
    super.key,
  });

  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Définir les couleurs pour les messages utilisateur et IA
    final Color messageColor = isFromUser ? theme.primaryColor : Colors.grey[300]!;
    final Color textColor = isFromUser ? Colors.white : Colors.black87;

    // Définir l'alignement pour les messages utilisateur et IA
    final CrossAxisAlignment alignment =
    isFromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // Définir les bords arrondis pour les bulles de chat
    final BorderRadius borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(15.0),
      topRight: const Radius.circular(15.0),
      bottomLeft: isFromUser ? const Radius.circular(15.0) : const Radius.circular(0.0),
      bottomRight: isFromUser ? const Radius.circular(0.0) : const Radius.circular(15.0),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0), // Espacement entre les messages
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: messageColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75, // Largeur max pour les bulles
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}