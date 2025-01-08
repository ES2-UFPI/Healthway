import 'package:flutter/material.dart';
import 'rating_stars.dart';

class ReviewCard extends StatelessWidget {
  final String authorName;
  final double rating;
  final String comment;
  final String date;

  const ReviewCard({
    Key? key,
    required this.authorName,
    required this.rating,
    required this.comment,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  authorName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 4),
            RatingStars(rating: rating, size: 18),
            SizedBox(height: 8),
            Text(
              comment,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

