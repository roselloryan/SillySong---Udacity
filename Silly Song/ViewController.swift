
import UIKit

func shortNameForName(_ name: String) -> String {
    
    let vowelSet = CharacterSet.init(charactersIn: "aeiouyAEIOUY")
    
    for (index, uni) in name.unicodeScalars.enumerated() {
        
        if vowelSet.contains(uni) {
            
            if (uni == "y" || uni == "Y") && index == 0 {
                // skip y's if they start the name i.e. 'Yuli'
                if index < name.characters.count - 2 && !vowelSet.contains(UnicodeScalar(String(name[name.index(name.startIndex, offsetBy: index + 1)]))!) {
                    return name.lowercased()
                }
            }
            else {
                let shortName = name.substring(from: name.index(name.startIndex, offsetBy: index))
                
                return shortName.lowercased()
            }
        }
    }
    
    return name.lowercased()
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameForName(fullName)
    
    let lyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    print(lyrics)
    return lyrics
}


// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }
    
    
    @IBAction func reset(_ sender: UITextField) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: UITextField) {
        
        if let name = nameField.text {
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
        }
    }
    
}

