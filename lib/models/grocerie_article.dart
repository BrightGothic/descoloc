class Groceries {
  String id;
  String name, brand, quantity, addedBy;

  Groceries(
       this.id,
       this.name,
       this.brand,
       this.quantity,
       this.addedBy);

  //Obtain a Groceries from a JSON data
  factory Groceries.fromJSON(Map<String, dynamic> j) => Groceries(
       j['id'],
       j['name'],
       j['brand'],
       j['quantity'],
       j['addedBy']);

  //Obtain a JSON file from a Groceries class
  Map<String, dynamic> toMap() =>
      {"id": id,"name": name, "brand": brand, "quantity": quantity, "addedBy":addedBy};
}
