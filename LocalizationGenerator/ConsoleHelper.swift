//
//  ConsoleHelper.swift
//  LocalizationGenerator
//
//  Created by iOS신상우 on 11/21/23.
//

import Foundation

enum OutputType {
    case error
    case basic
}

struct ConsoleHelper {
    static func printMessage(_ message: String,
                             outputType type: OutputType = .basic) {
        switch type {
        case .basic:
            print("\(message)")
        case .error:
            fputs("*** Error *** \n \(message)\n----------------------", stderr)
        }
    }

    static func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        
        guard let stringData = String(data: inputData,
                                      encoding: .utf8) else {
            printMessage("Failed to encode the input file",
                         outputType: .error)
            return ""
        }
        
        return stringData.trimmingCharacters(in: .newlines)
    }
}
