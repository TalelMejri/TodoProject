class Todo{

  String name;
  String? id;
  String description;
  DateTime due_Date;

   Todo(
      {required this.name,
      required this.description,
      required this.due_Date,
      });
      factory Todo.fromJson(Map<String,dynamic> json){
        return Todo(
          description: json['description'],
          name: json['name'],
          due_Date: json['due_Date'],
        );
      }

  Map<String, dynamic> toJson() {
    return {
        'description': description, 
        'name': name, 
        'due_Date': due_Date
      };
  }
 
}