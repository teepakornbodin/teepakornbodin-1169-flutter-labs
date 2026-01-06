import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/models/pet_model.dart';
import 'package:teepakornbodin_widgets_exercises/components/pet_card_with_model.dart';

class PetsGalleryScreen extends StatelessWidget {
  const PetsGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create PetModel instances
    final birdPet = PetModel(
      name: "Bird",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT34k4mCvWbGCbqsPW5W4iS4M2lF0tPV9vtlg&s",
    );

    final dogPet = PetModel(
      name: "Dog",
      imageUrl:
          "https://hips.hearstapps.com/hmg-prod/images/best-dog-breeds-for-kids-golden-retriever-6760f3b0cf166.jpg?crop=0.535xw:1.00xh;0.271xw,0",
      backgroundColor: Colors.brown,
    );

    final catPet = PetModel(
      name: "Cat",
      imageUrl:
          "https://moderncat.com/wp-content/uploads/2015/03/bigstock-405819263_-Lena42r-940x640.jpg",
      textColor: Colors.yellow,
    );

    final rabbitPet = PetModel(
      name: "Rabbit",
      imageUrl:
          "https://i.pinimg.com/736x/2d/15/74/2d157475da3f359c2bfcd10875aaa872.jpg",
      backgroundColor: Colors.green,
      textColor: Colors.yellow,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Gallery"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(child: PetCardWithModel(pet: birdPet)),
              ),
              Expanded(
                child: Center(child: PetCardWithModel(pet: dogPet)),
              ),
            ],
          ),
          const SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(child: PetCardWithModel(pet: catPet)),
              ),
              Expanded(
                child: Center(child: PetCardWithModel(pet: rabbitPet)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
