import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/components/pet_card.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Pet App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(
                child: PetCard(
                  petName: 'Bird',
                  petImagePath:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT34k4mCvWbGCbqsPW5W4iS4M2lF0tPV9vtlg&s',
                ),
              ),
              Expanded(
                child: PetCard(
                  petName: 'Dog',
                  petImagePath:
                      'https://hips.hearstapps.com/hmg-prod/images/best-dog-breeds-for-kids-golden-retriever-6760f3b0cf166.jpg?crop=0.535xw:1.00xh;0.271xw,0',
                ),
              ),
            ],
          ),
          const SizedBox(height: 200), // ปรับเพื่อให้แสดงผลลัพธ์เหมือนตัวอย่่าง
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(
                child: PetCard(
                  petName: 'Cat',
                  petImagePath:
                      'https://moderncat.com/wp-content/uploads/2015/03/bigstock-405819263_-Lena42r-940x640.jpg',
                ),
              ),
              Expanded(
                child: PetCard(
                  petName: 'Rabbit',
                  petImagePath:
                      'https://i.pinimg.com/736x/2d/15/74/2d157475da3f359c2bfcd10875aaa872.jpg',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
