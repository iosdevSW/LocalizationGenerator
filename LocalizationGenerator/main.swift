//
//  main.swift
//  LocalizationGenerator
//
//  Created by iOS신상우 on 11/21/23.
//

import Foundation

// TODO: - 1. bundlePath에 csv파일 넣기
// TODO: - 2. 디버깅 창에 확장자 포함 csv파일명 입력
// TODO: - 3. 뽑을 언어 ( 스프레드시트 헤드 열 이름 )입력
// TODO: - 4. BundlePath에 생성된 Localizable 파일 프로젝트에 추가해주기


// MARK: - 파일 저장 경로 및 안내레이블 출력

let bundlePath = Bundle.main.bundlePath
print(bundlePath) 
// 해당 경로에 inputFile 넣어주세요.

ConsoleHelper.printMessage("Enter the CSV file name: \n(** ex: CSVFileName.csv **)\n")

let fileName = ConsoleHelper.getInput()

// MARK: - 파일 이름 입력
let inputPath = bundlePath + "/" + fileName
ConsoleHelper.printMessage("File Path: " + inputPath)

// MARK: - 생성할 언어 입력
ConsoleHelper.printMessage("Enter language codes ** ex) kr,en ... **")
let languages = ConsoleHelper.getInput()

let generator = LocalizationFileGenerator(inputPath: inputPath,
                                          outputPath: bundlePath,
                                          langCodes: languages)

// MARK: - 생성기 실행
generator.generateLocalisation()



