import 'package:flutter/material.dart';

Widget buildDetailRow(
    BuildContext context, IconData icon, String label, String value,
    {bool wrapText = false}) {
  final theme = Theme.of(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: wrapText
        ? Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: theme.iconTheme.color),
            const SizedBox(width: 8),
            Text(
              '$label: ',
              style: theme.textTheme.titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(value, style: theme.textTheme.titleSmall),
      ],
    )
        : Row(
      children: [
        Icon(icon, size: 20, color: theme.iconTheme.color),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: theme.textTheme.titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(value, style: theme.textTheme.titleSmall),
        ),
      ],
    ),
  );
}

Widget buildInfoCard(
    BuildContext context, IconData icon, String title, Widget content) {
  final theme = Theme.of(context);
  return Card(
    elevation: 4,
    color: theme.cardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: theme.iconTheme.color),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    ),
  );
}

Widget buildInfoDoc(
    BuildContext context, IconData icon, String title, String message) {
  final theme = Theme.of(context);
  return Card(
    elevation: 4,
    color: theme.cardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: theme.iconTheme.color),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    ),
  );
}

Widget buildSection(
    BuildContext context, IconData icon, String title, List<String> items) {
  final theme = Theme.of(context);
  double screenWidth = MediaQuery.of(context).size.width;
  double cardWidth = screenWidth * 0.9;
  double maxCardWidth = 350;

  return Card(
    elevation: 4,
    color: theme.cardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxCardWidth,
        minWidth: cardWidth < maxCardWidth ? cardWidth : maxCardWidth,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24, color: theme.iconTheme.color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 10,
                children:
                items.map((item) => _buildItem(context, item)).toList(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildItem(BuildContext context, String item) {
  final theme = Theme.of(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.secondary, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        item,
        style: theme.textTheme.titleSmall!
            .copyWith(color: theme.colorScheme.secondary),
      ),
    ),
  );
}

Widget buildTextField(
    BuildContext context, TextEditingController controller, String label,
    {bool obscureText = false, String? Function(String?)? validator}) {
  final theme = Theme.of(context);
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      fillColor: theme.inputDecorationTheme.fillColor,
      filled: true,
    ),
    style: theme.textTheme.titleSmall,
    obscureText: obscureText,
    validator: validator ??
            (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
  );
}

Widget settingScreenItem(
    BuildContext context, {
      IconData? icon,
      String? imagePath,
      required String itemName,
      required String page,
    }) {
  final theme = Theme.of(context);

  return ListTile(
    leading: SizedBox(
      width: 24,
      height: 24,
      child: icon != null
          ? Center(child: Icon(icon, color: theme.primaryColor, size: 22))
          : imagePath != null
          ? Center(child: Image.asset(imagePath, width: 20, height: 20))
          : null,
    ),
    title: Text(itemName, style: theme.textTheme.titleSmall),
    onTap: () {
      Navigator.pushNamed(context, page);
    },
  );
}

class CustomLoadingScreen extends StatelessWidget {
  final String message;
  final Color indicatorColor;

  const CustomLoadingScreen({
    super.key,
    this.message = "...",
    this.indicatorColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.cardColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your logo at the top
            const SizedBox(height: 24), // Space between logo and the progress indicator
            CircularProgressIndicator(
              color: indicatorColor,
              strokeWidth: 4.0, // Optional: Adjust thickness
            ),
            const SizedBox(height: 24), // Space between indicator and message
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
                 // Slightly bolder text for better visibility
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildFloatingButton({
  required VoidCallback onPressed,
  String tag = "",
  IconData icon = Icons.add,
  String image = "",
  required Color backgroundColor,
}) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: FloatingActionButton(
      heroTag: tag,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      elevation: 0,
      highlightElevation: 0,
      child: image.isEmpty
          ? Icon(icon, color: Colors.white)
          : SizedBox(
        width: 40,
        child: Image.asset(
          image,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}


void showSnackBar(BuildContext context, String content) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: SlideTransitionSnackBar(
            content: content,
          ),
        ),
      );
    },
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}


class SlideTransitionSnackBar extends StatefulWidget {
  final String content;

  const SlideTransitionSnackBar({
    super.key,
    required this.content,
  });

  @override
  State<SlideTransitionSnackBar> createState() => _SlideTransitionSnackBarState();
}

class _SlideTransitionSnackBarState extends State<SlideTransitionSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Material(
          color: Colors.blue,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.content,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _controller.reverse();
                  },
                  child: const Text(
                    "Dismiss",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

