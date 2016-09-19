//
//  ViewController.swift
//  DebugBsp
//
//  Created by Christian Bleske on 18.03.15.
//  Copyright (c) 2015 Christian Bleske. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet var uiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fillLabel()
        errorSample()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func fillLabel() {
        let myString = "Hallo Welt"
        print(myString)
        uiLabel.text = myString
        //doLoop()
    }
    
    func doLoop() {
        var myvar:String
        var index=0
        
        //Nur bis Swift 2.2 -> //for var index=0; index < 5; index++ {
        while (index < 5) {
            myvar = String(index)
            print(myvar)
            index += 1
        }
    }
    
    func errorSample() {
        let jstring = "{ \"test\": \"bsp\" }"
        let daten = jstring.data(using: String.Encoding.utf8, allowLossyConversion: true)
        var nsError = NSError()
        
        var jresult :  Any?
        do {
            jresult = try JSONSerialization.jsonObject(with: daten!, options: .allowFragments)
        } catch let error as NSError {
            nsError = error
            jresult = nil
        }
        
        if jresult != nil {
            print("Alles ok!")
        } else {
            print("Fehler bei Umwandlung")
            
        }
    }
    
    func throwsPossibleError(_ input:Int) throws -> String {
        let result:String
    
        switch input {
            case 1...3:
                throw MyBigBadError.small
    
            case 4...6:
                throw MyBigBadError.medium
    
            case 7...9:
                throw MyBigBadError.big
    
            default:
                result = "Passed"
        }
        return result
    }
    
    func testError() {
        do {
            let result = try throwsPossibleError(5)
            print("Alles ok - es wurde kein Fehler geworfen")
            print(result)
        } catch MyBigBadError.small {
            print("Nur ein kleiner Fehler")
        } catch MyBigBadError.medium {
            print("Ein mittlerer Fehler")
        } catch MyBigBadError.big {
            print("Ein großer Fehler")
        } catch {
            print("Keine Ahnung, was passiert ist!")
        }
    }
    
    func testErrorMitDefer() {
        defer {
            print("defer wurde ausgeführt!")
        }
        
        do {
            let result = try throwsPossibleError(5)
            print("Alles ok - es wurde kein Fehler geworfen")
            print(result)
        } catch MyBigBadError.small {
            print("Nur ein kleiner Fehler")
        } catch MyBigBadError.medium {
            print("Ein mittlerer Fehler")
        } catch MyBigBadError.big {
            print("Ein großer Fehler")
        } catch {
            print("Keine Ahnung, was passiert ist!")
        }
    }

}

enum MyBigBadError: Error {//ErrorProtocol {
    case small
    case medium
    case big
}
