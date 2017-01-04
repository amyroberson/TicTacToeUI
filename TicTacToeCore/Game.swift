//
//  Game.swift
//  TicTacToeFiles
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

class Game: NSObject, NSCoding {
    var lastPlayed: Marker
    let rows: Int
    let columns: Int
    var grid: [Marker]
    var player1: Player
    var player2: Player
    var gameOutCome: GameOutcome?
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        self.rows = 3
        self.columns = 3
        self.grid = Array(repeating: .empty, count: rows * columns)
        self.lastPlayed = Marker.empty
    }
    
    init(lastPlayed:Marker, grid: [Marker], player1: Player, player2: Player, gameOutCome: GameOutcome?){
        self.lastPlayed = lastPlayed
        self.rows = 3
        self.columns = 3
        self.grid = grid
        self.player1 = player1
        self.player2 = player2
        self.gameOutCome = gameOutCome
    }
    
    //MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        var lastPlayed: Marker
        let tmp = decoder.decodeObject(forKey: "lastPlayed") as? String
        if tmp == "x" {
            lastPlayed = Marker.x
        }else if tmp == "o" {
            lastPlayed = Marker.o
        } else {
            lastPlayed = Marker.empty
        }
        
        var grid: [Marker] = []
        if let tmpGrid = decoder.decodeObject(forKey: "grid") as? [String] {
            for tmp in tmpGrid{
                if tmp == Marker.x.toString() {
                    grid.append(Marker.x)
                }else if tmp == Marker.o.toString() {
                    grid.append(Marker.o)
                } else {
                    grid.append(Marker.empty)
                }
            }
        } else {
            return nil
        }
        guard let player1 = decoder.decodeObject(forKey: "player1") as? Player,
            let player2 = decoder.decodeObject(forKey: "player2") as? Player else {
                return nil
        }
        var gameOutCome: GameOutcome?
        let tmpOutCome = decoder.decodeObject(forKey: "gameOutCome") as? String
        if tmpOutCome == GameOutcome.player1Wins.description{
            gameOutCome = GameOutcome.player1Wins
        } else if tmpOutCome == GameOutcome.player2Wins.description{
            gameOutCome = GameOutcome.player2Wins
        } else if tmpOutCome == "nil" || tmpOutCome == nil {
            gameOutCome = nil
        } else {
            gameOutCome = GameOutcome.draw
        }
        
        self.init(
            lastPlayed: lastPlayed,
            grid: grid,
            player1: player1,
            player2: player2,
            gameOutCome: gameOutCome
        )
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.lastPlayed.toString(), forKey: "lastPlayed")
        coder.encode(self.rows, forKey: "rows")
        coder.encode(self.columns, forKey: "column")
        coder.encode(self.grid.map{$0.toString()}, forKey: "grid")
        coder.encode(self.player1, forKey: "player1")
        coder.encode(self.player2, forKey: "player2")
        coder.encode(self.gameOutCome?.description, forKey: "gameOutCome")
    }
    
    
    
    override var description: String
    {
        return " \(self[0,0].toString()) | \(self[0,1].toString()) | \(self[0,2].toString())\n --------- \n \(self[1,0].toString()) | \(self[1,1].toString()) | \(self[1,2].toString()) \n --------- \n \(self[2,0].toString()) | \(self[2,1].toString()) | \(self[2,2].toString())"
    }
    
    subscript(row: Int, column: Int) -> Marker {
        get {
            do{
                return try self.get(row: row, column: column)
            }catch {
                fatalError() // can not throw from subscript
            }
        }
        
        set {
            do{
                try self.add(marker: newValue, at: (row: row, column: column))
            }catch {
                fatalError()  // can not throw from subscript
            }
        }
    }
    func get(row: Int, column:Int) throws -> Marker {
        if (row < rows && row > -1) &&
            (column < columns && column > -1) {
            return grid[(row * columns) + column]
        } else {
            throw BoardError.notOnBoard
        }
    }
    
    func add(marker: Marker, at: (row: Int, column: Int)) throws {
        if (at.row < rows && at.row > -1) &&
            (at.column < columns && at.column > -1) {
            grid[(at.row * columns) + at.column] = marker
        } else {
            throw BoardError.notOnBoard
        }
    }
    
   
    
    func getCurrentPlayer() -> Player {
        if player1.marker != lastPlayed {
            return player1
        } else {
            return player2
        }
    }
    
    func placeMove(input:(x:Int, y: Int)){
        if (input.x * self.columns + input.y) < 9 && (input.x * self.columns + input.y)  > -1 {
            self[input.x, input.y] = self.getCurrentPlayer().marker
            lastPlayed = getCurrentPlayer().marker
        }
    }
    
    /*func getCoordinatesFromUser(currentPlayer: Player) -> Bool {
        print("\(currentPlayer.name), It is your turn, pick a space!")
        print(self.description)
        do{
            let askUserForSpace = self.getSpace(x: getIntFromTheUser(prompt: "\(currentPlayer.name) Please enter a number 0, 1, or 2 for the row"), y: getIntFromTheUser(prompt: "\(currentPlayer.name) Please enter a number 0, 1, or 2 for the column"), currentPlayer: currentPlayer)
            let validMove = try self.evaluateandPlace(input: askUserForSpace, currentPlayer: currentPlayer)
            return validMove
        } catch TurnError.outOfTurn {
            print("It is not your turn!")
        } catch TurnError.spaceNotAvailable {
            print("That space is taken!")
        } catch {
            print("There was an error")
        }
        return false
    }*/
    
    func getSpace(x: Int, y: Int, currentPlayer: Player) -> (Int, Int){
        return (x,y)
    }
    
    static func ==(_ lhs: Game, _ rhs: Game) -> Bool{
        return lhs.grid == rhs.grid &&
            lhs.player1 == rhs.player1 &&
            lhs.player2 == rhs.player2 &&
            lhs.gameOutCome == rhs.gameOutCome
    }
    
    func thereIsAWinner() ->  Marker {
        if (self[0,0] == .x) && (self[0,1] == .x) && (self[0,2] == .x){
            return .x
        } else if (self[0,0] == .o) && (self[0,1] == .o) && (self[0,2] == .o){
            return .o
        } else if (self[1,0] == .x) && (self[1,1] == .x) && (self[1,2] == .x){
            return .x
        } else if (self[1,0] == .o) && (self[1,1] == .o) && (self[1,2] == .o){
            return .o
        } else if (self[2,0] == .x) && (self[2,1] == .x) && (self[2,2] == .x){
            return .x
        } else if (self[2,0] == .o) && (self[2,1] == .o) && (self[2,2] == .o){
            return .o
        } else if (self[0,0] == .x) && (self[1,1] == .x) && (self[2,2] == .x){
            return .x
        } else if (self[0,0] == .o) && (self[1,1] == .o) && (self[2,2] == .o){
            return .o
        } else if (self[0,0] == .x) && (self[1,0] == .x) && (self[2,0] == .x){
            return .x
        } else if (self[0,0] == .o) && (self[1,0] == .o) && (self[2,0] == .o){
            return .o
        } else if (self[0,1] == .x) && (self[1,1] == .x) && (self[2,1] == .x){
            return .x
        } else if (self[0,1] == .o) && (self[1,1] == .o) && (self[2,1] == .o){
            return .o
        } else if (self[0,2] == .x) && (self[1,2] == .x) && (self[2,2] == .x){
            return .x
        } else if (self[0,2] == .o) && (self[1,2] == .o) && (self[2,2] == .o){
            return .o
        } else if (self[0,2] == .x) && (self[1,1] == .x) && (self[2,0] == .x){
            return .x
        } else if (self[0,2] == .o) && (self[1,1] == .o) && (self[2,0] == .o){
            return .o
        } else {
            return .empty
        }
    }
    
    func isBoardFull() -> Bool {
        for i in self.grid{
            if i == .empty{
                return false
            }
        }
        return true
    }
    
    func isGameOver() -> Bool{
        if self.thereIsAWinner() != .empty {
            if self.thereIsAWinner() == .x {
                self.gameOutCome = .player1Wins
            }else if self.thereIsAWinner() == .o {
                self.gameOutCome = .player2Wins
            } else {
                self.gameOutCome = .draw
            }
            return true
        }
        if self.isBoardFull() {
            self.gameOutCome = .draw
            return true
        }
        return false
    }
}