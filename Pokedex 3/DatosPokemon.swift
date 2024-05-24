//
//  DatosPokemon.swift
//  Pokedex
//
//  Created by Carlos Suchite 04/20/2024.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
}
