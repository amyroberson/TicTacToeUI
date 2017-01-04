//
//  Player.swift
//  TicTacToeFiles
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation


public class Player: NSObject, NSCoding {
    public let marker: Marker
    public let name: String
    public fileprivate(set) var numberOfWins : Int
    public fileprivate(set) var numberOfLosses: Int
    override public var description: String {
        return self.name

    }
    
    public convenience init(name: String, mark: Marker){
        self.init(name:name, mark:mark, numberOfWins: 0, numberOfLosses: 0)
    }
    
    init(name: String, mark: Marker, numberOfWins: Int, numberOfLosses: Int){
        self.name = name
        self.marker = mark
        self.numberOfWins = numberOfWins
        self.numberOfLosses = numberOfLosses
    }
    
    //MARK: NSCoding
    required convenience public init?(coder decoder: NSCoder) {
        var marker: Marker
        let tmp = decoder.decodeObject(forKey: "marker") as? String
        if tmp == "x" {
            marker = Marker.x
        }else if tmp == "o" {
            marker = Marker.o
        } else {
            marker = Marker.empty //this needs to be tested by having a file read a player with marker .empty
        }
        guard let name = decoder.decodeObject(forKey: "name") as? String
            else {return nil}
        self.init(
            name: name,
            mark: marker,
            numberOfWins: decoder.decodeInteger(forKey: "numberOfWins"),
            numberOfLosses: decoder.decodeInteger(forKey: "numberOfLosses")
        )
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        var tmp: String
        if self.marker == .x {
            tmp = "x"
        } else if self.marker == .o{
            tmp = "o"
        } else {
            tmp = "empty"
        }
        coder.encode(tmp, forKey: "marker")
        coder.encode(self.numberOfWins, forKey: "numberOfWins")
        coder.encode(self.numberOfLosses, forKey: "numberOfLosses")
    }
    
    public static func ==(_ lhs: Player, _ rhs: Player) -> Bool{
        return lhs.name == rhs.name && lhs.marker == rhs.marker && lhs.numberOfWins == rhs.numberOfWins
        
    }
}
