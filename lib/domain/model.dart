class NaverSearch {
  final int? id;
  final String name;

  NaverSearch({this.id, required this.name});

  factory NaverSearch.fromMap(Map<String, dynamic> json) => new NaverSearch(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}