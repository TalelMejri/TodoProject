class Todo{

  String? id;
  String name;
  String description;
  bool isdone;
  DateTime due_Date;

   Todo(
      {required this.name,
      required this.description,
      required this.due_Date,
      required this.isdone
      });
      factory Todo.fromJson(Map<String,dynamic> json){
        return Todo(
          description: json['description'],
          name: json['name'],
          due_Date: DateTime.parse(json['due_Date']),
          isdone: json['isdone']
        );
      }

  Map<String, dynamic> toJson() {
    return {
        'description': description, 
        'name': name, 
        'due_Date': due_Date
      };
  }

   @override
  String toString() {
    return 'Todo{id: $id, name: $name, description: $description, isdone: $isdone, due_Date: $due_Date}';
  }
 
}