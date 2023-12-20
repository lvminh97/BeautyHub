import 'package:flutter/material.dart';

class DeleteProductDialog extends StatelessWidget {
  final String name;

  const DeleteProductDialog({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      title: const Text(
        'Xóa sản phẩm này ?',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: RichText(
          text: TextSpan(
              text: 'Bạn có chắc chắn muốn xóa ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              children: [
            TextSpan(
                text: name,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
            const TextSpan(
                text: ' không ?',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ))
          ])),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Hủy bỏ',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context, 'confirmDelete');
            },
            child: const Text(
              'Xác nhận',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.green,
              ),
            ))
      ],
    );
  }
}
