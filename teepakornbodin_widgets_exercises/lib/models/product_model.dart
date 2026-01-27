class ProductModel {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });

  static List<ProductModel> getProducts() {
    return const [
      ProductModel(
        id: 1,
        name: 'Wireless Headphones',
        price: 1290.00,
        imageUrl: 'assets/images/wireless_headphones.jpg',
        description:
            '"Experience immersive high-fidelity audio with these premium wireless headphones. Engineered with advanced Active Noise Cancellation (ANC) technology, they effectively block out ambient noise, allowing you to focus entirely on your music or calls. Featuring plush memory foam ear cushions for all-day comfort, a foldable design for maximum portability, and a robust battery life of up to 30 hours. Equipped with Bluetooth 5.0 for a stable, lag-free connection and an integrated HD microphone for crystal-clear voice quality.',
        rating: 4.5,
      ),
      ProductModel(
        id: 2,
        name: 'Smart Watch Pro',
        price: 2490.00,
        imageUrl: 'assets/images/smart_watch.jpg',
        description:
            'The Smart Watch Pro is your ultimate personal health and fitness companion. It features a vibrant 1.5-inch AMOLED display that remains crystal clear even under direct sunlight. Beyond simple timekeeping, it offers comprehensive health tracking including 24/7 heart rate monitoring, SpO2 blood oxygen levels, stress analysis, and advanced sleep stage tracking. With over 100 professional sports modes and an IP68 water resistance rating, it is built to withstand your most intense workouts and outdoor adventures.',
        rating: 4.0,
      ),
      ProductModel(
        id: 3,
        name: 'Portable Speaker',
        price: 890.00,
        imageUrl: 'assets/images/portable_speaker.jpg',
        description:
            'A compact yet powerful Bluetooth speaker engineered with dual drivers to deliver immersive 360-degree room-filling sound. The rugged, waterproof IPX7-rated exterior makes it the perfect choice for pool parties, beach outings, and unpredictable outdoor environments. Enjoy up to 12 hours of continuous high-quality playtime on a single charge. It also features a built-in noise-canceling microphone for hands-free speakerphone calls and supports True Wireless Stereo (TWS) pairing to link two units for a wider soundstage.',
        rating: 4.2,
      ),
      ProductModel(
        id: 4,
        name: 'Laptop Stand',
        price: 590.00,
        imageUrl: 'assets/images/laptop_stand.jpg',
        description:
            'Elevate your workspace and your posture with this premium ergonomic laptop stand. Crafted from high-grade aircraft-quality aluminum, it provides a stable and secure platform for laptops ranging from 11 to 17 inches. The adjustable height and tilt angles allow you to align your screen perfectly with your eye level, significantly reducing neck strain and back pain. Its open-frame design facilitates maximum airflow to prevent your device from overheating, and the foldable mechanism ensures it fits easily into your bag.',
        rating: 4.3,
      ),
      ProductModel(
        id: 5,
        name: 'Mechanical Keyboard',
        price: 1990.00,
        imageUrl: 'assets/images/mechanical_keyboard.jpg',
        description:
            'Unleash your productivity and gaming potential with this high-performance mechanical keyboard. Featuring tactile and responsive mechanical switches, every keystroke provides satisfying feedback and extreme precision. The keyboard boasts customizable per-key RGB backlighting with millions of color combinations to suit your aesthetic. Built with a durable top plate and N-key rollover technology, it ensures that every command is registered accurately. Includes a detachable USB-C cable for easy transport and longevity.',
        rating: 4.8,
      ),
      ProductModel(
        id: 6,
        name: 'Wireless Mouse',
        price: 690.00,
        imageUrl: 'assets/images/wireless_mouse.jpg',
        description:
            'Designed for both style and efficiency, this wireless mouse features a sleek, ergonomic contour that fits naturally in your hand to minimize fatigue during long working hours. The high-precision optical sensor offers adjustable DPI settings (800/1200/1600), providing smooth and accurate tracking on almost any surface. Its silent-click technology reduces noise by 90%, making it ideal for quiet office environments or late-night sessions. Powered by a single AA battery with an intelligent auto-sleep mode to extend battery life for months.',
        rating: 4.1,
      ),
    ];
  }
}
