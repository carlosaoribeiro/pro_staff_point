class Employee {
  final String id;
  final String name;
  final String role;

  Employee({
    required this.id,
    required this.name,
    required this.role,
  });

  // 👇 Método para salvar no SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
    };
  }

  // 👇 Método para ler do SQLite
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as String,
      name: map['name'] as String,
      role: map['role'] as String,
    );
  }
}
