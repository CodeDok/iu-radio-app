import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:radio_app/bloc/rating/rating_result.dart';





class RatingFormWidget extends StatefulWidget {
  const RatingFormWidget({super.key, required this.value, required this.processResult, this.maxCommentLength = 50});

  final Function(RatingResult) processResult;
  final String value;
  final int maxCommentLength;

  @override
  State<RatingFormWidget> createState() => _RatingFormWidgetState();
}

class _RatingFormWidgetState extends State<RatingFormWidget> {
  final _textController = TextEditingController();

  int currentRating = 1;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                widget.value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                wrapAlignment: WrapAlignment.end,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double rating) {
                  currentRating = rating.toInt();
                },
              ),
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: "(optional) Comment",
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value != null && value.length >= widget.maxCommentLength) {
                    return "Comment can't exceed ${widget.maxCommentLength} characters!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 50),
              FloatingActionButton(
                heroTag: "Rate",
                onPressed: () {
                  widget.processResult(
                    RatingResult(currentRating, comment: _textController.text)
                  );
                },
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
