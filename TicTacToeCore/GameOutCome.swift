//
//  GameOutCome.swift
//  TicTacToeFiles
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

enum GameOutcome: CustomStringConvertible {
    case player1Wins
    case player2Wins
    case draw
    
    var description: String {
        switch self{
        case .player1Wins:
            return "player1Wins"
        case .player2Wins:
            return "player2Wins"
        case .draw:
            return "draw"
        }
    }
}
