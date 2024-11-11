import 'dart:async';

enum Role { Admin, Customer }

class Product {
  String productName;
  double price;
  bool inStock;

  Product(this.productName, this.price, this.inStock);
}

class User {
  String name;
  int age;
  late List<Product> products;
  Role? role;

  User(this.name, this.age) {
    products = [];
  }
}

class AdminUser  extends User {
  AdminUser (String name, int age) : super(name, age) {
    role = Role.Admin;
  }

  void addProduct(Product product) {
    if (product.inStock) {
      products.add(product);
      print('${product.productName} has been added.');
    } else {
      throw Exception('Product is out of stock.');
    }
  }

  void removeProduct(Product product) {
    products.remove(product);
    print('${product.productName} has been removed.');
  }
}

class CustomerUser  extends User {
  CustomerUser (String name, int age) : super(name, age) {
    role = Role.Customer;
  }

  void viewProducts() {
    print('Available Products:');
    for (var product in products) {
      print('${product.productName} - \$${product.price} - ${product.inStock ? "In Stock" : "Out of Stock"}');
    }
  }
}

Future<Product> fetchProductDetails(String productName) async {
  // Simulating network delay
  await Future.delayed(Duration(seconds: 2));
  // Returning a sample product
  return Product(productName, 99.99, true);
}

void main() async {
  // Create an AdminUser 
  AdminUser  admin = AdminUser ("Alice", 30);
  
  // Create a unique set of products
  Set<String> uniqueProductNames = {};

  try {
    // Fetch product details asynchronously
    Product newProduct = await fetchProductDetails("Laptop");
    
    // Check if the product is unique
    if (uniqueProductNames.add(newProduct.productName)) {
      admin.addProduct(newProduct);
    } else {
      print('Product ${newProduct.productName} already exists.');
    }

    // Fetch another product
    Product anotherProduct = await fetchProductDetails("Smartphone");
    if (uniqueProductNames.add(anotherProduct.productName)) {
      admin.addProduct(anotherProduct);
    } else {
      print('Product ${anotherProduct.productName} already exists.');
    }

    // Create a CustomerUser 
    CustomerUser  customer = CustomerUser ("Bob", 25);
    
    // Share products with the customer
    customer.products = admin.products;

    // Customer views products
    customer.viewProducts();

    // Remove a product
    admin.removeProduct(newProduct);
    
    // Customer views products again
    customer.viewProducts();

  } catch (e) {
    print('Error: $e');
  }
}