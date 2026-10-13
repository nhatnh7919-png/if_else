import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradeClassificationScreen(),
    );
  }
}

class GradeClassificationScreen extends StatelessWidget {
  const GradeClassificationScreen({super.key});

  // 2. Viết một hàm nhận vào điểm và trả về xếp loại
  String getGradeClassification(double score) {
    if (score < 0 || score > 10) {
      return 'Không hợp lệ';
    } else if (score >= 8.0) {
      return 'Giỏi';
    } else if (score >= 6.5) {
      return 'Khá';
    } else if (score >= 5.0) {
      return 'Trung bình';
    } else {
      return 'Yếu';
    }
  }

  // Hàm phụ trợ để lấy màu chữ/nền cho từng loại xếp loại dựa trên if
  Color getGradeColor(String classification, {bool isBackground = false}) {
    if (classification == 'Giỏi') {
      return isBackground ? Colors.green.shade100 : Colors.green.shade800;
    } else if (classification == 'Khá') {
      return isBackground ? Colors.blue.shade100 : Colors.blue.shade800;
    } else if (classification == 'Trung bình') {
      return isBackground ? Colors.orange.shade100 : Colors.orange.shade800;
    } else if (classification == 'Yếu') {
      return isBackground ? Colors.red.shade100 : Colors.red.shade800;
    } else {
      return isBackground ? Colors.grey.shade300 : Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Khai báo một biến điểm có giá trị 8.5
    const double mainScore = 8.5;
    final String mainClassification = getGradeClassification(mainScore);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Xếp loại học lực'),
        backgroundColor: const Color(0xFF274374), // Màu xanh đen
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF3F4F6), // Màu nền xám nhạt
      body: SingleChildScrollView(
        // Thêm SingleChildScrollView để tránh lỗi tràn màn hình trên thiết bị nhỏ
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3. Hiển thị điểm và xếp loại chính
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Điểm trung bình',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      mainScore.toString(),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: getGradeColor(
                          mainClassification,
                          isBackground: true,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        mainClassification,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: getGradeColor(mainClassification),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Tiêu đề phần kiểm tra thêm
              const Text(
                'KIỂM TRA THÊM',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),

              // 4. Phần "Kiểm tra thêm": gọi hàm với các điểm 9, 7, 5.5, 3 và 11
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildTestItem(9.0),
                    _buildDivider(),
                    _buildTestItem(7.0),
                    _buildDivider(),
                    _buildTestItem(5.5),
                    _buildDivider(),
                    _buildTestItem(3.0),
                    _buildDivider(),
                    _buildTestItem(11.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget hiển thị từng dòng kiểm tra thêm
  Widget _buildTestItem(double score) {
    String classification = getGradeClassification(score);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Điểm ${score % 1 == 0 ? score.toInt() : score}', // Định dạng hiển thị số nguyên nếu phần thập phân là 0
            style: const TextStyle(fontSize: 16),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: getGradeColor(classification, isBackground: true),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              classification,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: getGradeColor(classification),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dòng kẻ ngăn cách giữa các mục (Dùng Container thay vì Divider theo yêu cầu)
  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.grey.shade200,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }
}
