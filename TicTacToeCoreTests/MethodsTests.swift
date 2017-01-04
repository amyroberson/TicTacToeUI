//
//  MethodsTests.swift
//  TicTacToe2
//
//  Created by Amy Roberson on 12/16/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest
@testable import TicTacToeCore

class MethodsTests: XCTestCase {

    func testSwitch(){
        let x: Marker = .x
        let expected = "X"
        let result = x.toString()
        XCTAssertEqual(expected, result)
    }
    
    func testSwitch1(){
        let x: Marker = .o
        let expected = "O"
        let result = x.toString()
        XCTAssertEqual(expected, result)
    }
   
    func testSwitch2(){
        let x: Marker = .empty
        let expected = " "
        let result = x.toString()
        XCTAssertEqual(expected, result)
    }
    
    func testPlayerDescripton(){
        let player1 = Player(name: "Sally", mark: .x)
        let player2 = Player(name: "", mark: .x)
        XCTAssertEqual("Sally", player1.description)
        XCTAssertEqual("", player2.description)
    }
    
    
    }
