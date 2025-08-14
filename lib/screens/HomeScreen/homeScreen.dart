import 'package:flutter/material.dart';
import 'package:pakmart/Model/GlobalServices.dart';
import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/api/ProductApi.dart';
import 'package:pakmart/constant/screensize.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/HomeScreen/widgets/ProductsHorizontalListView.dart';
import 'package:pakmart/screens/HomeScreen/widgets/categories.dart';
import 'package:pakmart/screens/Products/ProductsScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final List<String> productImages = [
    "https://img.freepik.com/premium-photo/apple-macbook-space-grey-realistic-mockup-transparent-png-digital-design-visualization_209190-137923.jpg",
    "https://e7.pngegg.com/pngimages/68/524/png-clipart-red-wireless-headphones-wearing-headphones.png",
  ];

  final List<String> categories = ["Headphones", "Camera"];

  late Future<Map<String, List<Product>>> _categoryProducts;

  @override
  void initState() {
    super.initState();
    _categoryProducts = _fetchCategoryProducts();
  }

  Future<Map<String, List<Product>>> _fetchCategoryProducts() async {
    final Map<String, List<Product>> productsByCategory = {};
    for (final category in categories) {
      final products = await ProductApi().getProductsByCategory(category);
      productsByCategory[category] = products;
    }
    return productsByCategory;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<Product>>>(
      future: _categoryProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final categoryProducts = snapshot.data ?? {};

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
            title: Image.asset(
              "lib/assets/logo/49eb77a2-94d7-4ce5-8038-5309d56705df-removebg-preview.png",
              scale: 4,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SliderWidget(
                  pageController: _pageController,
                  productImages: productImages,
                ),
                Categories(listOfItems: globalServices),
                for (final category in categories)
                  CategorySection(
                    category: category,
                    products: categoryProducts[category] ?? [],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.pageController,
    required this.productImages,
  });

  final PageController pageController;
  final List<String> productImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Screensize(context: context).screenheight / 2.5,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: productImages.length,
            itemBuilder: (context, index) {
              return Image.network(
                productImages[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text("Image not available"));
                },
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: productImages.length,
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 15,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.category,
    required this.products,
  });

  final String category;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => context.navigateTo(ProductsScreen(category: category)),
          leading: Text(category, style: const TextStyle(fontSize: 20)),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
        if (products.isNotEmpty)
          ProductsHorizontalListView(ListofProducts: products)
        else
          const Center(child: Text('No products available.')),
      ],
    );
  }
}
