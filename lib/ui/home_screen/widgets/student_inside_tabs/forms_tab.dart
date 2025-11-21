import 'package:flutter/material.dart';

class FormsTab extends StatelessWidget {
  const FormsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Medical Form Card
            GestureDetector(
              onTap: () {
                // Navigate to the medical form page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MedicalForm()),
                );
              },
              child: Card(
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.medical_services,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Medical Form',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Nutrition Form Card
            GestureDetector(
              onTap: () {
                // Navigate to the nutrition form page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NutritionForm()),
                );
              },
              child: Card(
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.fastfood,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Nutrition Form',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for the Medical Form Page
class MedicalForm extends StatelessWidget {
  const MedicalForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Form'),
      ),
      body: const Center(
        child: Text('Medical Form Content Goes Here'),
      ),
    );
  }
}

// Placeholder for the Nutrition Form Page
class NutritionForm extends StatelessWidget {
  const NutritionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Form'),
      ),
      body: const Center(
        child: Text('Nutrition Form Content Goes Here'),
      ),
    );
  }
}
