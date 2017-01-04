//
//  Marker.swift
//  TicTacToeFiles
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

enum Marker{
    case x
    case o
    case empty
    
    func toString() -> String {
        switch self{
        case .x:
            return "X"
        case .o:
            return "O"
        case .empty:
            return " "
        }
    }
}
