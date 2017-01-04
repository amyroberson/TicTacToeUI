//
//  FileInteraction.swift
//  TicTacToeFiles
//
//  Created by Amy Roberson on 1/4/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

func getHistoryFilePath() throws -> URL{
    guard let supportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
        throw FileError.noSupportDirectory
    }
    var supportFile = supportDir.appendingPathComponent("TicTacToe")
    try FileManager.default.createDirectory(at: supportFile, withIntermediateDirectories: true, attributes: nil)
    supportFile = supportFile.appendingPathComponent("history.plist")
    return supportFile
}

func loadSavedGames() -> [Game] {
    var gameArray: [Game] = []
    do {
        let file = try getHistoryFilePath()
        if FileManager.default.fileExists(atPath: file.path) {
            if let tmp = NSKeyedUnarchiver.unarchiveObject(withFile: file.path) as? [Game] {
                gameArray = tmp
            }
        }
    } catch{
        print("failed to load history")
        print("\(error)")
    }
    return gameArray
}

func saveGameHistory(games: [Game]) {
    do {
        let file = try getHistoryFilePath()
        if NSKeyedArchiver.archiveRootObject(games, toFile: file.path) {
            print("Saved History @ \(file)")
        }
    } catch {
        print("\(error)")
    }
}
