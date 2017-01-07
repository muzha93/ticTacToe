//
//  Player.swift
//  KrizicKruzic
//
//  Created by luka on 05/01/2017.
//  Copyright © 2017 luka. All rights reserved.
//

import Foundation

enum Player {
    case X
    case O
}

enum Result {
    case win(Player)
    case tie
}
enum TileState {
    case occupied(Player)
    case empty
}
    
