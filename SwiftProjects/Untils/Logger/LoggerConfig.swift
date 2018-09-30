//
//  LoggerConfig.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/30.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation
import XCGLogger

public let log: XCGLogger = {
    let log = XCGLogger.default
    let logPath : NSURL = cacheDirectory.appendingPathComponent("XCGLogger.Log")! as NSURL
    // By using Swift build flags, different log levels can be used in debugging versus staging/production. Go to Build settings -> Swift Compiler - Custom Flags -> Other Swift Flags and add -DDEBUG to the Debug entry.
    #if DEBUG
    log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath)
    #else
    log.setup(level: severe, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath)
    #endif
    
    if let fileDestination: FileDestination = log.destination(withIdentifier: XCGLogger.Constants.fileDestinationIdentifier) as? FileDestination {
        let ansiColorLogFormatter: ANSIColorLogFormatter = ANSIColorLogFormatter()
        ansiColorLogFormatter.colorize(level: .verbose, with: .colorIndex(number: 244), options: [.faint])
        ansiColorLogFormatter.colorize(level: .debug, with: .black)
        ansiColorLogFormatter.colorize(level: .info, with: .blue, options: [.underline])
        ansiColorLogFormatter.colorize(level: .warning, with: .red, options: [.faint])
        ansiColorLogFormatter.colorize(level: .error, with: .red, options: [.bold])
        ansiColorLogFormatter.colorize(level: .severe, with: .white, on: .red)
        fileDestination.formatters = [ansiColorLogFormatter]
        
        log.add(destination: fileDestination)
        
    }
    
    
//    log.xcodeColorsEnabled = true
//    log.xcodeColors = [
//        .Verbose: .lightGrey,
//        .Debug: .darkGrey,
//        .Info: .darkGreen,
//        .Warning: .orange,
//        .Error: .red,
//        .Severe: .whiteOnRed
//    ]
    return log
}()



private var documentsDirectory: NSURL {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.endIndex-1] as NSURL
}

private var cacheDirectory: NSURL {
    let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
    return urls[urls.endIndex-1] as NSURL
}


public struct NetworkLog {
    static let ESCAPE = "\u{001b}["
    
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    typealias StatusCode = Int
    static func out(statusCode: StatusCode, target: (baseURL: NSURL, path: String, method: String, parameters: [String: AnyObject]?), json: AnyObject) {
        var codeColor = "fg255,0,0"
        if statusCode == 200 {
            codeColor = "fg0,255,0"
        }
        print("\(ESCAPE)\(codeColor);\(statusCode)\(RESET) \(ESCAPE)fg53,255,206;\(target.method)\(RESET) \(ESCAPE)fg69,69,69;\(target.baseURL)\(target.path) \(target.parameters ?? [:])\(RESET) \n\(ESCAPE)fg29,29,29;\(json)\(RESET)")
    }
}
