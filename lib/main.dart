import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BookHome(),
      title: "Aluguel de Livros",
    );
  }
}

//Book Home Screen

class BookHome extends StatelessWidget {
  const BookHome({super.key});

  // Custom Style Text
  static const TextStyle customStyleHeader =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle customStyle =
      TextStyle(fontSize: 16, decoration: TextDecoration.underline);
  static const imageUrlProps =
      "https://ps.w.org/mooberry-book-manager/assets/icon-128x128.png?rev=1122342";

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aluguel de Livros'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        backgroundColor: Colors.green,
        child: ListView(
          children: const [
            ListTile(
              title: Text('Opção 1'),
            ),
            ListTile(
              title: Text('Opção 2'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Olá, vamos reservar seu livro hoje?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                BookRoomCard(
                  imageUrl: imageUrlProps,
                  roomName: "Livro 1",
                  address: "Biblioteca Fulano - Av. Paz, 001",
                  pages: "50",
                  price: "R\$ 50,00",
                ),
                BookRoomCard(
                  imageUrl: imageUrlProps,
                  roomName: "Livro 2",
                  address: " Biblioteca Cicrano - Rua Amizade, 005",
                  pages: "45",
                  price: "R\$ 40,00",
                ),
                BookRoomCard(
                  imageUrl: imageUrlProps,
                  roomName: "Livro 3",
                  address: "Bilioteca Beltrano - Praça Alegria, 009",
                  pages: "100",
                  price: "R\$ 60,00",
                ),
                BookRoomCard(
                  imageUrl: imageUrlProps,
                  roomName: "Livro 4",
                  address: "Biblioteca Teste - Av. Exemplo, 159",
                  pages: "250",
                  price: "R\$ 50,00",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookRoomCard extends StatelessWidget {
  final String imageUrl;
  final String roomName;
  final String address;
  final String pages;
  final String price;

  const BookRoomCard({
    Key? key,
    required this.imageUrl,
    required this.roomName,
    required this.address,
    required this.pages,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.4,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(roomName, style: BookHome.customStyleHeader),
                  const SizedBox(height: 8),
                  Text("Endereço: $address", style: BookHome.customStyle),
                  const SizedBox(height: 8),
                  Text("Páginas: $pages", style: BookHome.customStyle),
                  const SizedBox(height: 8),
                  Text("Preço referência: $price", style: BookHome.customStyle),
                  const SizedBox(height: 12),
                  const BookingButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingButton extends StatefulWidget {
  const BookingButton({super.key});

  @override
  _BookingButtonState createState() => _BookingButtonState();
}

class _BookingButtonState extends State<BookingButton> {
  bool _isBooked = false;

  void _toggleBooking() {
    setState(() {
      _isBooked = !_isBooked;
    });
    final message = _isBooked ? 'Reserva realizada!' : 'Reserva cancelada!';
    _showAlert(context, 'Reserva', message);
  }

  void _showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleBooking,
      child: Text(_isBooked ? 'Cancelar Reserva' : 'Reservar Agora'),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isBooked ? Colors.red : Colors.green,
      ),
    );
  }
}
