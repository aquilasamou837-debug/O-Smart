import 'package:flutter/material.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({super.key});

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  bool isManuel = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commande", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(1000),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 8,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "ON",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.play_arrow),
                          label: Text('Démarrer'),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.stop),
                          label: Text('Arrêter'),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SwitchListTile(
              title: Text('Passer en mode manuel'),
              subtitle: Text(
                'Contrôler manuellement le pompage et la source d\'alimentation',
              ),
              value: isManuel,
              onChanged: (val) => setState(() => isManuel = val),
              secondary: Icon(Icons.auto_mode), // icône à gauche
              activeThumbColor: Colors.blue,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // pousse aux bords
                          children: [
                            Text('Pompe AC', style: TextStyle(fontSize: 16)),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red, // fait un rond parfait
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            SourceAlimButtons(),
                            SizedBox(height: 10),
                            ToggleButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // pousse aux bords
                          children: [
                            Text('Pompe DC', style: TextStyle(fontSize: 16)),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red, // fait un rond parfait
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            SourceAlimButtons(),
                            SizedBox(height: 10),
                            ToggleButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bouton des source d'alimentation
class SourceAlimButtons extends StatefulWidget {
  const SourceAlimButtons({super.key});
  @override
  State<SourceAlimButtons> createState() => _SourceAlimButtonsState();
}

class _SourceAlimButtonsState extends State<SourceAlimButtons> {
  int selectedIndex = 1; // -1 = aucun sélectionné

  Widget buildSquareButton({
    required int index,
    required IconData icon,
    required Color activeColor,
  }) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: FilledButton(
          onPressed: () {
            setState(() {
              selectedIndex = index; // active ce bouton
            });
          },
          style: FilledButton.styleFrom(
            backgroundColor: isSelected ? activeColor : Colors.grey.shade300,
            disabledBackgroundColor: Colors.grey.shade200,
            foregroundColor: isSelected ? Colors.white : Colors.grey.shade600,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Icon(icon, size: 32),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildSquareButton(
          index: 0,
          icon: Icons.solar_power,
          activeColor: Colors.blue,
        ),
        SizedBox(width: 12),
        buildSquareButton(index: 1, icon: Icons.bolt, activeColor: Colors.blue),
        SizedBox(width: 12),
        buildSquareButton(
          index: 2,
          icon: Icons.local_gas_station,
          activeColor: Colors.blue,
        ),
      ],
    );
  }
}

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});
  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        setState(() => isActive = !isActive);
      },
      style: FilledButton.styleFrom(
        backgroundColor: isActive ? Colors.green : Colors.red,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
      ),
      child: Text(
        isActive ? 'Démarrer la pompage' : 'Arrêter le pompage',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
