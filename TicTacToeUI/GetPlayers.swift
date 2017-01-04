//
//  GetPlayers.swift
//  TicTacToeUI
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation
import TicTacToeCore

class GetPlayers{
    let player1 = Player(name: "First Player", mark: .x)
    let player2 = Player(name:"Second Player", mark: .o)
    var players: [Player]
    init(){
        players = [player1, player2]
    }
}
