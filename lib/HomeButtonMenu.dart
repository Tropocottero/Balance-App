import 'package:flutter/material.dart';

// funzione culo
List<String> limitaSelezione(String selezione){
  if(selezione == 'ent'){return ['Stipendio', 'Commisioni', 'Altro'];}
  else {return ['Alimentari','Trasporti','Affitto e Spese','Intrattenimento','Altro'];}
}

// classe per cambiare opzioni del secondo DropdownMenu
class opzioniNotifier with ChangeNotifier{
  String? _opzioneSelezionata = '';

  String? get opzioneSelezionata => _opzioneSelezionata;

  void confermaSelezione(String? selezione){
    _opzioneSelezionata = selezione;
    notifyListeners();
  }
}


class PopupMenuHome extends StatefulWidget {
  const PopupMenuHome({super.key});

  @override
  State<PopupMenuHome> createState() => _PopupMenuHomeState();
}
class _PopupMenuHomeState extends State<PopupMenuHome> {

  final opzioniNotifier _notifierPadre = opzioniNotifier();
  TextEditingController _valoreTran = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(


      // Titolo del Popup
      title: const Text("Nuova Transazione"),

      // Contenuto del Popup
      content: Padding(padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [


          // 2 Widget superiori con menu a selezione
          Row(
            children: [
              // Widget per la Tipologia di Transazione
              DropDownTipologia(listaOggetti: ['ent','usc'], notifierFiglio: _notifierPadre),

              // Widget per la causale della transazione
              DropdownMenuCausale(
                  oggetti: limitaSelezione(_notifierPadre.opzioneSelezionata!),
                  notifierFiglio: _notifierPadre,
              ),
            ],
          ),


          // Widget inferiore che permette di inserire la cifra
          Container(
            //color: Colors.purple,
            child: TextField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'valore della Transazione'
              ),
              controller: _valoreTran,
            ),
          )
        ],
      )),

      // Pulsante di Conferma Finale
      actions: [
        TextButton(
            onPressed: () {
              print(_valoreTran.text);  // printa il valore della Transazione
              Navigator.pop(context);  // chiude il Popup
            },
            child: Text('Conferma'))
      ],
    );
  }
}


class DropDownTipologia extends StatefulWidget {
  const DropDownTipologia({super.key, required this.listaOggetti, required this.notifierFiglio});

  final opzioniNotifier notifierFiglio;
  final List<String> listaOggetti;

  @override
  State<DropDownTipologia> createState() => _DropDownTipologiaState();
}
class _DropDownTipologiaState extends State<DropDownTipologia> {

  String? _valoreSelezionato = 'usc';

  // funzione per impostare il colore del testo se necessario
  Color CheckUscEnt(String contenuto) {
    if (contenuto == 'usc'){return Colors.red;}
    else if (contenuto == 'ent'){ return Colors.green; }
    else {return Colors.black;}
  }

  // funzione per costruire gli Item del Dropdown menu
  DropdownMenuItem<String> CostruisciOpzioni(String contenuto) => DropdownMenuItem(
    value: contenuto,
    child: Text(contenuto, style: TextStyle(color: CheckUscEnt(contenuto)),),
  );

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String> (
      value: _valoreSelezionato, // Inserisce il valore di default nel menu
      icon: const Icon(Icons.arrow_drop_down), // Icona a sinistra del menu

      items: widget.listaOggetti.map(CostruisciOpzioni).toList(),
      // Prende ogni valore di _modalita e costruisce un opzione, .toList le inserisce in una lista

      onChanged: (String? value) {
        setState(() => _valoreSelezionato = value);
        widget.notifierFiglio.confermaSelezione(value);
        },
      // Aggiorna il widget cambiando la scelta selezionata se necesario

    );
  }
}


class DropdownMenuCausale extends StatefulWidget {
  const DropdownMenuCausale({super.key, required this.oggetti, required this.notifierFiglio});

  final opzioniNotifier notifierFiglio;
  final List<String> oggetti;

  @override
  State<DropdownMenuCausale> createState() => _DropdownMenuCausaleState();
}
class _DropdownMenuCausaleState extends State<DropdownMenuCausale> {

  String? _valoreSelezionato;

  // funzione per costruire gli Item del Dropdown menu
  DropdownMenuItem<String> CostruisciOpzioni(String contenuto) => DropdownMenuItem(
    value: contenuto,
    child: Text(contenuto),
  );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.notifierFiglio,
      builder: (BuildContext context, Widget? child) {

        print(widget.notifierFiglio.opzioneSelezionata); // PORCODDIO

        return DropdownButton<String>(
          value: _valoreSelezionato,
          // Inserisce il valore di default nel menu
          icon: const Icon(Icons.arrow_drop_down),
          // Icona a sinistra del menu

          items: widget.oggetti.map(CostruisciOpzioni).toList(),
          // Prende ogni valore di _modalita e costruisce un opzione, .toList le inserisce in una lista

          onChanged: (String? value) {
            setState(() => _valoreSelezionato = value);
          },
        );
      },
    );
  }
}
