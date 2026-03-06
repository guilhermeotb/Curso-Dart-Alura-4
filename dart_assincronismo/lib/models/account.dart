class Account {
  String id;
  String name;
  String lastname;
  double balance;

  Account({
    required this.id,
    required this.name,
    required this.lastname,
    required this.balance,
  });


  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map["id"],
      name: map["name"],
      lastname: map["lastname"],
      balance: map["balance"],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "lastname": lastname,
      "balance": balance,
    };
  }

}