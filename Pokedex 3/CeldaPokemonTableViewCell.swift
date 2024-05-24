//
//  CeldaPokemonTableViewCell.swift
//  Pokedex
//
//  Created by Carlos Suchite 04/20/2024.
//

import UIKit

class CeldaPokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var defensePokemon: UILabel!
    @IBOutlet weak var attackPokemon: UILabel!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var imagenPokemon: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagenPokemon.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
