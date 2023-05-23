//
//  DevConsoleScriptMessageHandler.swift
//  Sky
//

import WebKit

class DevConsoleScriptMessageHandler : NSObject, WKScriptMessageHandler {

    var viewController: DevConsoleViewController!

    var nameFns:[String:(WKScriptMessage) -> Void] {
        return [
            "consoleLog": ScriptMessageHandler.consoleLog,
            "triggerLoadAccessJwt": triggerLoadAccessJwt,
        ]
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        if let fn = nameFns[message.name] {
            fn(message)
        } else {
            NSLog("unknown message: \(message)")
        }
    }

    func triggerLoadAccessJwt(_ message: WKScriptMessage) {
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        if let accessJwt = appDelegate.getActiveAccessJwt() {
            viewController?.setAccessJwt(accessJwt)
        }
    }

}