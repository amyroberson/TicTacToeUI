//
//  Marker.swift
//  TicTacToeFiles
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

public  enum Marker{
    case x
    case o
    case empty
    
    public func toString() -> String {
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
