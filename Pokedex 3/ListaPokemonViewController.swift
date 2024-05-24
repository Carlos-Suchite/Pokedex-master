//
//  ViewController.swift
//  Pokedex
//
//  Created by Carlos Suchite 04/20/2024
//

import UIKit

class ListaPokemonViewController: UIViewController {
    
    
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    
    @IBOutlet weak var searchPokemonTextField: UITextField!
    
    
    @IBOutlet weak var tablaPokemon: UITableView!
    
  
    var pokemonManager = PokemonManager()
    
    var pokemons: [Pokemon] = []
    
    var pekemonSeleccionado: Pokemon?
    
    var pokemonFiltrados: [Pokemon] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        tablaPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        pokemonManager.delegado = self
        
    
        searchPokemonTextField.delegate = self
        
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        
        
        pokemonManager.verPokemon()
        
        
    }
}



extension ListaPokemonViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        pokemonFiltrados = []
        
        if textField.text == "" {
            pokemonFiltrados = pokemons
        } else {
            for poke in pokemons {
                if poke.name.lowercased().contains(textField.text!) {
                    pokemonFiltrados.append(poke)
                }
            }
        }
        self.tablaPokemon.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        textField.endEditing(true)
        return true
    }
}


extension ListaPokemonViewController: pokemonManagerDelegado {
    func mostrarListaPokemon(list: [Pokemon]) {
        pokemons = list
        
        DispatchQueue.main.async {
            self.pokemonFiltrados = list
            self.tablaPokemon.reloadData()
        }
    }
    
    
}


extension ListaPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPokemonTableViewCell
        
        celda.namePokemon.text = pokemonFiltrados[indexPath.row].name
        celda.attackPokemon.text = "Attack: \(pokemonFiltrados[indexPath.row].attack)"
        celda.defensePokemon.text = "Defense: \(pokemonFiltrados[indexPath.row].defense)"
        
        
        
        if let urlString = pokemonFiltrados[indexPath.row].imageUrl as? String {
            if let imagenURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL) else { return }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.imagenPokemon.image = image
                    }
                }
            }
        }
        
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pekemonSeleccionado = pokemonFiltrados[indexPath.row]
        
        performSegue(withIdentifier: "verPokemon", sender: self)
        
     
        tablaPokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPokemon" {
            let verPokemon = segue.destination as! DetallePokemonViewController
            verPokemon.pokemonShow = pekemonSeleccionado
        }
    }
    
}
