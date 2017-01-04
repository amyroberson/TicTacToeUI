//
//  ViewController.swift
//  TicTacToeUI
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import UIKit
import TicTacToeCore

public class TicTacToeViewController: UIViewController {
    public let game: Game

    @IBOutlet var topLeft: UIButton!
    @IBOutlet var topMiddle: UIButton!
    @IBOutlet var topRight: UIButton!
    @IBOutlet var middleLeft: UIButton!
    @IBOutlet var middleMiddle: UIButton!
    @IBOutlet var middleRight: UIButton!
    @IBOutlet var bottomLeft: UIButton!
    @IBOutlet var bottomMiddle: UIButton!
    @IBOutlet var bottomRight: UIButton!
    @IBOutlet var playerTurnLabel: UILabel!
    @IBOutlet var gameOutComeLabel: UILabel!
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        let info = GetPlayers().players
        self.game = Game(player1: info[0], player2: info[1])
        super.init(coder: aDecoder)!
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getCoodinates(input: UIButton) -> (Int,Int){
        let coordinates: [(Int,Int)] = [(0,0), (0,1), (0,2), (1,0), (1,1), (1,2), (2,0), (2,1), (2,2)]
        let buttonLocation = coordinates[input.tag]
        return buttonLocation
        }
    
    
    func Update(){
        topLeft.setTitle(game[0,0].toString(), for: .normal)
        topMiddle.setTitle(game[0,1].toString(), for: .normal)
        topRight.setTitle(game[0,2].toString(), for: .normal)
        middleLeft.setTitle(game[1,0].toString(), for: .normal)
        middleMiddle.setTitle(game[1,1].toString(), for: .normal)
        middleRight.setTitle(game[1,2].toString(), for: .normal)
        bottomLeft.setTitle(game[2,0].toString(), for: .normal)
        bottomMiddle.setTitle(game[2,1].toString(), for: .normal)
        bottomRight.setTitle(game[2,2].toString(), for: .normal)
        playerTurnLabel.text = game.getCurrentPlayer().description
        if game.isGameOver(){
            gameOutComeLabel.text = game.gameOutCome.description
        } 
    }
    
    
    @IBAction func selectSpot(_ sender:UIButton){
        if game.isGameOver(){
            Update()
        } else {
        game.placeMove(input: getCoodinates(input: sender))
        Update()
        }
    }

    
    

}

