//
//  LocalizationFileGenerator.swift
//  LocalizationGenerator
//
//  Created by iOS신상우 on 11/21/23.
//

import Foundation
import SwiftCSV

struct LocalizationFileGenerator {
    private let fileManager = FileManager.default
    
    private let inputPath: String
    private let outputPath: String
    private let langCodes: [String]
    
    init(inputPath: String,
         outputPath: String,
         langCodes: String...)
    {
        self.inputPath = inputPath
        self.outputPath = outputPath
        self.langCodes = langCodes
    }
    
    func generateLocalisation() {
        for code in langCodes {
            generateLocalizable(langCode: code)
        }
    }
    
    /// CSV파일 읽고 Localizable String 파일 text 입력
    private func generateLocalizable(langCode: String) {
        do {
            let csv = try CSV<Named>.init(url: URL(fileURLWithPath: inputPath),
                                          encoding: .utf8,
                                          loadColumns: false)

            var generatedString = getCrateTime()
                        
            for row in csv.rows {
                guard let key = row["id"] else {
                    ConsoleHelper.printMessage("The key header is not an 'id'.\nPlease check the key header and use the correct 'id'",
                                               outputType: .error)
                    return
                }
                
                let value = row[langCode] ?? "value is empty"
                
                generatedString += "\"\(key)\" = \"\(value)\";\n\n"
            }

            _ = generateFile(text: generatedString,
                             langCode: langCode)
        } catch {
            ConsoleHelper.printMessage("Unexpected error: \(error).")
        }
    }
    
    private func getCrateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return "//MARK: - Generated at " + formatter.string(from: Date()) + "\n"
    }

    
    /// 파일 생성
    private func generateFile(text: String,
                              langCode: String) -> Bool {
        
        let outputPath = URL(fileURLWithPath: outputPath)
        let langugePath = outputPath.appendingPathComponent("\(langCode).lproj")
        let filePath = langugePath.appendingPathComponent("Localizable.strings")
        
        do {
            if !fileManager.fileExists(atPath: langugePath.path) {
                try fileManager.createDirectory(atPath: langugePath.path,
                                                withIntermediateDirectories: true)
                ConsoleHelper.printMessage("Directory Created at: \(langugePath.absoluteString)")
            }
            
            try text.write(to: filePath,
                           atomically: true,
                           encoding: String.Encoding.utf8)
            
            ConsoleHelper.printMessage("File generated at: \(filePath.absoluteString)")
        } catch {
            
            ConsoleHelper.printMessage("Failed to generate \n\(error)",
                                       outputType: .error)
            return false
        }
        
        return true
    }
}
