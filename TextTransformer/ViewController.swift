//
//  ViewController.swift
//  TextTransformer
//
//  Created by Connor McDonough on 5/25/21.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var input: NSTextField!
    @IBOutlet weak var type: NSSegmentedControl!
    @IBOutlet weak var output: NSTextField!
    let zalgoCharacters = ZalgoCharacters()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typeChanged(self)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    
    @IBAction func typeChanged(_ sender: Any) {
            switch type.selectedSegment {
            case 0:
                output.stringValue = rot13(input:input.stringValue)
            case 1:
                output.stringValue = similar(input:input.stringValue)
            case 2:
                output.stringValue = strike(input:input.stringValue)
            default:
                output.stringValue = zalgo(input:input.stringValue)
            }
        }
    
    @IBAction func copyToPasteboard(_ sender: Any) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(output.stringValue, forType: .string)
    }
    
    func controlTextDidChange(_ obj: Notification) {
        typeChanged(self)
    }
    
    func rot13( input: String) -> String {
        return ROT13.string(input)
    }
    
    func similar( input: String) -> String {
        var output = input
        
        output = output.replacingOccurrences(of: "a", with: "а")
        output = output.replacingOccurrences(of: "e", with: "е")
        output = output.replacingOccurrences(of: "c", with: "с")
        output = output.replacingOccurrences(of: "o", with: "о")
        output = output.replacingOccurrences(of: "i", with: "і")
        output = output.replacingOccurrences(of: "A", with: "А")
        //Cyrillic
        return output
    }
    
    func strike( input: String) -> String {
        var output = ""
        
        for letter in input {
            output.append(letter)
            
            output.append("\u{0335}")
        }
        
        return output
    }
    
    func zalgo( input: String) -> String {
        var output = ""
        
        for letter in input {
            output.append(letter)
            
            for _ in 1...Int.random(in: 1...8) {
                output.append(zalgoCharacters.above.randomElement()!)
            }
            
            for _ in 1...Int.random(in: 1...3) {
                output.append(zalgoCharacters.inline.randomElement()!)
            }
            
            for _ in 1...Int.random(in: 1...8) {
                output.append(zalgoCharacters.below.randomElement()!)
            }
        }
        
        return output
    }
}

extension String {
    mutating func append(_ str: String?) {
        guard let str = str else { return }
        append(str)
    }
} //protection agaist empty string
