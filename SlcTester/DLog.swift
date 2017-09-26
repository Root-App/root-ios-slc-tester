//
//  DLog.swift
//  SlcTester
//
//  Created by Jimmy Devine on 9/26/17.
//  Copyright © 2017 Root. All rights reserved.
//

import Foundation

func DLog(_ format: String, _ args: CVarArg...) {
    #if DEBUG
        func buildLogString(argList: CVaListPointer) -> String {
            return NSString(format: format, arguments: argList) as String
        }
        Foundation.NSLog(withVaList(args, buildLogString))
    #endif
}
