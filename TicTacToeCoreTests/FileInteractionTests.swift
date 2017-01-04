//
//  FileInteractionTests.swift
//  TicTacToe2
//
//  Created by Amy Roberson on 12/17/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest
@testable import TicTacToeCore

class FileInteractionTests: XCTestCase {

    func testSavePlayer(){
        let person = Player(name: "Bob", mark: .x)
        let file = NSTemporaryDirectory().appending("/player")
        NSKeyedArchiver.archiveRootObject(person, toFile: file)
        let newPerson = NSKeyedUnarchiver.unarchiveObject(withFile: file) as! Player
        XCTAssert(person == newPerson)
    }
    
    func testSaveGame(){
        let p1 = Player(name: "Bob", mark: .x)
        let p2 = Player(name: "Sally", mark: .o)
        let game = Game(player1: p1, player2: p2)
        let file = NSTemporaryDirectory().appending("/game")
        NSKeyedArchiver.archiveRootObject(game, toFile: file)
        let newGame = NSKeyedUnarchiver.unarchiveObject(withFile: file) as! Game
        XCTAssert(game == newGame)
    }
    
    func testSaveGame1(){
        let p1 = Player(name: "Bob", mark: .x)
        let p2 = Player(name: "Sally", mark: .o)
        let game = Game(lastPlayed: .x, grid: [.x, .empty, .x, .o, .x, .o, .empty, .o ,.x], player1: p1, player2: p2, gameOutCome: .player1Wins)
        let file = NSTemporaryDirectory().appending("/game")
        NSKeyedArchiver.archiveRootObject(game, toFile: file)
        let newGame = NSKeyedUnarchiver.unarchiveObject(withFile: file) as! Game
        XCTAssert(game == newGame)
    }
    
    func testSaveGame2(){
    
        let p1 = Player(name: "Bob", mark: .x)
        let p2 = Player(name: "Sally", mark: .o)
        let game = Game(lastPlayed: .x, grid: [.x, .empty, .x, .o, .x, .o, .empty, .o ,.x], player1: p1, player2: p2, gameOutCome: .player1Wins)
        let game2 = Game(lastPlayed: .o, grid: [.x, .o, .o, .o, .x, .o, .o, .x ,.o], player1: p1, player2: p2, gameOutCome: .player2Wins)
        saveGameHistory(games: [game, game2])
        let games = loadSavedGames()
        XCTAssert(game == games[0])
        XCTAssert(game2 == games[1])
    }
    
    func testSaveGame3(){
        
        let p1 = Player(name: "Bob", mark: .x)
        let p2 = Player(name: "Sally", mark: .o)
        let game = Game(lastPlayed: .x, grid: [.x, .empty, .x, .o, .x, .o, .empty, .o ,.x], player1: p1, player2: p2, gameOutCome: .player1Wins)
        let game2 = Game(lastPlayed: .o, grid: [.x, .o, .x, .o, .x, .o, .o, .x ,.o], player1: p1, player2: p2, gameOutCome: .draw)
        saveGameHistory(games: [game, game2])
        let games = loadSavedGames()
        XCTAssert(game == games[0])
        XCTAssert(game2 == games[1])
    }
    
   
}
