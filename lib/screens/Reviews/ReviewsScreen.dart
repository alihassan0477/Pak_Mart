import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:pakmart/Model/ReviewModel.dart';
import 'package:pakmart/api/ReviewsApi.dart';
import 'package:pakmart/service/SharedPrefs.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.product_id});

  final String product_id;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  TextEditingController reviewTextController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Reviews"),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: ReviewsApi().get_Reviews_by_productId(widget.product_id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error in Fetching "),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Stack(
                  children: [
                    const Center(child: Text("No Review Found")),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _sendReviewButton(),
                    )
                  ],
                );
              }

              List<Review> reviews = snapshot.data!;

              return Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: reviews.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(reviews[index].customer_name ?? "null"),
                            subtitle: Text(
                              reviews[index].description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                            trailing: CustomRatingBar(
                              rating: reviews[index].rating,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _sendReviewButton(),
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget _sendReviewButton() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formkey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: reviewTextController,
                decoration: InputDecoration(
                  hintText: 'Type your message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the Description";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
                onPressed: _showRatingDialog, icon: const Icon(Icons.send))
          ],
        ),
      ),
    );
  }

  void _showRatingDialog() {
    int rating = 3;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Rating"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
                onPressed: () async {
                  final isValid = _formkey.currentState!.validate();

                  if (!isValid) {
                    return;
                  }
                  final customerId = await SharedPrefs.getUserID();
                  final productId = widget.product_id;

                  final description = reviewTextController.text;

                  final review = Review(
                      customer_name: null,
                      description: description,
                      rating: rating);

                  final response = await ReviewsApi()
                      .sendReview(review, customerId, productId);

                  if (response == "Review Created Succesfully") {
                    Future.delayed(
                      const Duration(milliseconds: 300),
                      () => Navigator.pop(context),
                    );

                    setState(() {
                      reviewTextController.clear();
                    });
                  }
                },
                child: const Text("Submit")),
          ],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Please enter rating"),
              RatingBar(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                onRatingChanged: (value) {
                  rating = value.toInt();
                },
                initialRating: rating.toDouble(),
                maxRating: 5,
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomRatingBar extends StatelessWidget {
  CustomRatingBar({super.key, required this.rating});

  int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          color: index < rating ? Colors.amber : Colors.grey,
        ),
      ),
    );
  }
}
