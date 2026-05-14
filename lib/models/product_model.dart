class Store {
  final int id;
  final String name;
  final String username;

  Store({
    required this.id,
    required this.name,
    required this.username,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
    };
  }
}

class ProductClass {
  final int id;
  final String name;

  ProductClass({
    required this.id,
    required this.name,
  });

  factory ProductClass.fromJson(Map<String, dynamic> json) {
    return ProductClass(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Product {
  final int id;
  final String name;
  final String price;
  final String description;
  final String createdAt;
  final String updatedAt;
  final Store store;
  final ProductClass productClass;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.store,
    required this.productClass,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price']?.toString() ?? '0',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      store: Store.fromJson(json['store'] ?? {}),
      productClass: ProductClass.fromJson(json['class'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'store': store.toJson(),
      'class': productClass.toJson(),
    };
  }

  String get formattedPrice {
    final numPrice = double.tryParse(price) ?? 0;
    final intPrice = numPrice.toInt();

    final formatted = intPrice.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }
}

class ProductListResponse {
  final bool success;
  final String message;
  final List<Product> products;

  ProductListResponse({
    required this.success,
    required this.message,
    required this.products,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final productsList = data['products'] as List? ?? [];
    return ProductListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      products: productsList.map((p) => Product.fromJson(p)).toList(),
    );
  }
}

class Submission {
  final int id;
  final String name;
  final String price;
  final String description;
  final String githubUrl;
  final String submittedAt;
  final String createdAt;
  final String updatedAt;
  final Store store;
  final ProductClass submissionClass;

  Submission({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.githubUrl,
    required this.submittedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.store,
    required this.submissionClass,
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price']?.toString() ?? '0',
      description: json['description'] ?? '',
      githubUrl: json['github_url'] ?? '',
      submittedAt: json['submitted_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      store: Store.fromJson(json['store'] ?? {}),
      submissionClass: ProductClass.fromJson(json['class'] ?? {}),
    );
  }
}

class SubmitResponse {
  final bool success;
  final String message;
  final Submission? submission;

  SubmitResponse({
    required this.success,
    required this.message,
    this.submission,
  });

  factory SubmitResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return SubmitResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      submission: data != null && data['submission'] != null
          ? Submission.fromJson(data['submission'])
          : null,
    );
  }
}
