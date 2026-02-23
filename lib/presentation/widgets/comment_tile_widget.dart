import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/comment.dart';

class CommentTileWidget extends StatelessWidget {
  final Comment comment;

  const CommentTileWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera con nombre y email
          Row(
            children: [
              Icon(Icons.person_outline, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  comment.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            comment.email,
            style: TextStyle(fontSize: 12, color: Colors.blue.shade600),
          ),
          const SizedBox(height: 8),
          // Cuerpo del comentario
          Text(
            comment.body,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }
}
