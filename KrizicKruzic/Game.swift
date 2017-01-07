//
//  Game.swift
//  KrizicKruzic
//
//  Created by luka on 05/01/2017.
//  Copyright © 2017 luka. All rights reserved.
//

import Foundation

class Game {
    
    private var tiles = Array(repeating: Array(repeating: TileState.empty, count: 3), count: 3)
    private var gameStatus: Result? = nil
    

    init() {
        let selectedPlayer = UInt(arc4random_uniform(UInt32(2)))
        switch selectedPlayer {
        case 0:
            firstPlayer = Player.O
            currentPlayer = Player.O
            nextPlayer = Player.X
        default:
            firstPlayer = Player.X
            currentPlayer = Player.X
            nextPlayer = Player.O
        }
    }
    
    var firstPlayer: Player
    var currentPlayer:Player
    var nextPlayer: Player
    var numberOfMoves = 0
    
  var result: Result? {
        get{
            return gameStatus
        }
    }
    
    func nextMove(row: Int, col: Int) {
        numberOfMoves += 1
        let tile = tiles[row][col]
        switch tile {
        case .empty:
            tiles[row][col] = TileState.occupied(currentPlayer)
        default: break
        }
        gameStatus = isGameFinished(row: row, col: col)
        if gameStatus == nil {
            changePlayer()
        }
    }
    
    func changePlayer() {
        let player = currentPlayer
        currentPlayer = nextPlayer
        nextPlayer = player
    }
    
    func isGameFinished(row: Int, col: Int) -> Result? {
        if numberOfMoves > 4 {
            if columnIspection(col: col) || rowInspection(row: row) {
                return Result.win(currentPlayer)
            }
            if (row + col) == 2 || row == col {
                if rightDiagonalInspection() || leftDiagonalInspection() {
                    return Result.win(currentPlayer)
                }
            }
        }
        if numberOfMoves == 9 {
            return Result.tie
        }
        return nil
    }
    
    func columnIspection(col: Int) -> Bool {
        for i in 0...2 {
            let tile = tiles[i][col]
            
            if String(describing: tile) != String(describing: TileState.occupied(currentPlayer)) {
                return false
            } else if i == 2{
                return true
            }
        }
        return false
    }
    func rowInspection(row: Int) -> Bool {
        for j in 0...2 {
            let tile = tiles[row][j]
            if String(describing: tile) != String(describing: TileState.occupied(currentPlayer)) {
                return false
            } else if j == 2 {
                
                return true
            }
        }
        return false
    }
    func rightDiagonalInspection() -> Bool {
        var j = 2
        for i in 0...2 {
            let tile = tiles[i][j]
            if String(describing: tile) != String(describing: TileState.occupied(currentPlayer)) {
                return false
            } else if i == 2 {
                return true
            }
            j -= 1
        }
        return false
    }
    
    func leftDiagonalInspection() -> Bool {
        for i in 0...2 {
            let tile = tiles[i][i]
            if String(describing: tile) != String(describing: TileState.occupied(currentPlayer)) {
                return false
            } else if i == 2 {
                return true
            }
        }
        return false
    }
    
    func gameRestart() {
        numberOfMoves = 0
        if gameStatus == nil {
            if firstPlayer != currentPlayer {
                changePlayer()
            }
        } else {
            firstPlayer = nextPlayer
            changePlayer()
        }
        gameStatus = nil
        tiles = Array(repeating: Array(repeating: TileState.empty, count: 3), count: 3)
    }

    
}
