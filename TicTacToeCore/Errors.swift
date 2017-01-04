//
//  Errors.swift
//  TicTacToeFiles
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation


enum TurnError: Error {
    case outOfTurn
    case spaceNotAvailable
}

enum BoardError: Error {
    case notOnBoard
}

enum FileError: Error{
    case noSupportDirectory
}
