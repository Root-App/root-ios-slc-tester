//
//  CachedLog.swift
//  SlcTester
//
//  Created by Jimmy Devine on 9/26/17.
//  Copyright © 2017 Root. All rights reserved.
//

import Foundation

class CachedLog {
    fileprivate static let cachedLogRequestDirectory = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString)/cachedlog/"
    fileprivate static let cachedLogRequestFileExtension = "cachedlog"
    fileprivate static let currentFilename = timeString() + "__" + UUID().uuidString
    fileprivate static let dateFormatter = DateFormatter()
    fileprivate static var currentLog = "\n"
    fileprivate static var directoryCreated = false

    fileprivate static func timeString() -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH_mm_ss"
        return dateFormatter.string(from: Date())
    }

    fileprivate static func shortTimeString() -> String {
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }


    class func log(_ line: String) {
        if !directoryCreated {
            createDirectory()
        }

        let fullLine = "CachedLog: \(shortTimeString())--\(line) \n"

        DLog(fullLine)

        currentLog += fullLine

        if !NSKeyedArchiver.archiveRootObject(currentLog, toFile: filePath()) {
            DLog("Failed to archive CachedLog.")
            assert(false)
        }
    }

    fileprivate class func filePath() -> String {
        return "\(cachedLogRequestDirectory)/\(currentFilename).\(cachedLogRequestFileExtension)"
    }

    fileprivate class func createDirectory() {
        do {
            try FileManager.default.createDirectory(atPath: cachedLogRequestDirectory, withIntermediateDirectories: true, attributes: nil)
            directoryCreated = true
        } catch {
            DLog("File manager error creating directory: \(cachedLogRequestDirectory) in ReliableAPIRequestStore")
        }
    }
}
