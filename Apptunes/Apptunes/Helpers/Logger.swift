//
//  Logger.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit

struct Logger {
    // MARK: - Enums
    enum LogType: String {
        case info
        case success
        case warning
        case failure
        
        var symbol: String {
            switch self {
            case .info:
                return L10n.Literals.Symbol.blueCircle
            case .success:
                return L10n.Literals.Symbol.greenCircle
            case .warning:
                return L10n.Literals.Symbol.orangeCircle
            case .failure:
                return L10n.Literals.Symbol.redCircle
            }
        }
    }
    
    static func log(type: LogType, title: String = "", message: String = "", file: String = "", function: String = "", line: Int = -1) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        
        var logText = "Log: \(dateFormatter.string(from: Date()))"
        logText.append("\nType: \(type.rawValue.uppercased()) \(type.symbol) \(title)")
        
        
        if !file.isEmpty {
            logText.append("\nFile: \(file)")
        }
        
        if !function.isEmpty {
            logText.append("\nFunction: \(function)")
        }
        
        if line > 0 {
            logText.append("\nLine: \(line)")
        }
        
        if !message.isEmpty {
            logText.append("\nLogger message: \(message)")
        }
        
        #if DEBUG
        print(logText)
        #endif
    }
}
