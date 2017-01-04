//
//  GameOutCome.swift
//  TicTacToeFiles
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

public enum GameOutcome: CustomStringConvertible {
    case player1Wins
    case player2Wins
    case draw
    case none
    
    public var description: String {
        switch self{
        case .none:
            return ""
        case .player1Wins:
            return "player1Wins"
        case .player2Wins:
            return "player2Wins"
        case .draw:
            return "draw"
        }
    }
    
}
