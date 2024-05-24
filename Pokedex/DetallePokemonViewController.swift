//
//  DetallePokemonViewController.swift
//  Pokedex
//
//  Created by Carlos Suchite 04/20/2024
//

import UIKit

class DetallePokemonViewController: UIViewController {
    
    
    var pokemonShow: Pokemon?
    
    
   
    
    
    @IBOutlet weak var DefensePokemon: UILabel!
    @IBOutlet weak var AttackPokemon: UILabel!
    @IBOutlet weak var TypePokemon: UILabel!
    @IBOutlet weak var imagenPokemon: UIImageView!
    @IBOutlet weak var DescriptionPokemon: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        imagenPokemon.loadFrom(URLAddres: pokemonShow?.imageUrl ?? "")
        TypePokemon.text = "Type : \(pokemonShow?.type ?? "")"
        AttackPokemon.text = "Attack: \(pokemonShow!.attack)"
        DefensePokemon.text = "Defense: \(pokemonShow!.defense)"
        DescriptionPokemon.text = pokemonShow?.description ?? ""
        
    }
}


extension UIImageView {
    func loadFrom(URLAddres: String) {
        guard let url = URL(string: URLAddres) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
        .resume()
    }
}
