import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
        brightness: Brightness.dark,
      ),
      home: DashboardScreen(
        onThemeChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;

  const DashboardScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: const Text(
          'Plano Alimentar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              onThemeChanged(!isDarkMode);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeSelector(context, 'Dia', true),
                _buildTimeSelector(context, 'Semana', false),
                _buildTimeSelector(context, 'Mês', false),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMainCard(isDarkMode),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildSmallCard('7h 30m', 'Sleep Duration', 'assets/sleep.png', isDarkMode)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildSmallCard('350 kcal', 'Burned', 'assets/burned.png', isDarkMode)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildSmallCard('More Self Love', 'Fulfilment', 'assets/selflove.png', isDarkMode)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildSmallCard('80 bpm', 'Avg Heart Rate', 'assets/heartrate.png', isDarkMode)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4), // Menor altura
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF31BAC2).withOpacity(0.5), // Cor com 50% de transparência
              Color(0xFF51E8F1).withOpacity(0.5), // Cor com 50% de transparência
            ],
            begin: Alignment.topLeft, // Posição inicial do gradiente
            end: Alignment.bottomRight, // Posição final do gradiente
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30)), // Borda de 30px
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Fundo transparente
          currentIndex: 0,
          onTap: (int index) {
            // Handle the bottom navigation taps here
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.white),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.white),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          elevation: 0, // Para remover a sombra padrão
        ),
      ),
    );
  }

  Widget _buildTimeSelector(BuildContext context, String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Add navigation or interaction if necessary
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF31BAC2).withOpacity(0.5), // Cor com 50% de transparência
              Color(0xFF51E8F1).withOpacity(0.5), // Cor com 50% de transparência
            ],
            begin: Alignment.topLeft, // Posição inicial do gradiente
            end: Alignment.bottomRight, // Posição final do gradiente
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF31BAC2).withOpacity(0.5), // Cor com 50% de transparência
            Color(0xFF51E8F1).withOpacity(0.5), // Cor com 50% de transparência
          ],
          begin: Alignment.topLeft, // Posição inicial do gradiente
          end: Alignment.bottomRight, // Posição final do gradiente
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black54 : Colors.grey[300]!, // Sombra suave para o card
            blurRadius: 10,
            offset: Offset(0, 4), // Deslocamento da sombra
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Quality',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Indicador de progresso (circular)
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: 0.84,
                  strokeWidth: 8,
                  backgroundColor: isDarkMode ? Colors.grey[700] : Colors.green[100],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              const Text(
                '84.19%',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Informações adicionais no card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text('1698 kcal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Consumed', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black54)),
                ],
              ),
              Column(
                children: [
                  const Text('302 kcal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Remaining', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black54)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildSmallCard(String title, String subtitle, String assetPath, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green, // Verde mais suave e dessaturado
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(assetPath, height: 50),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(color: isDarkMode ? Colors.grey : Colors.black54),
          ),
        ],
      ),
    );
  }
}
