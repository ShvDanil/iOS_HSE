//  The first Homework.
//  dishvetsovPW1
//
//  Created by Danil Shvetsov on 18.09.2022.
//

import UIKit

/// Main ViewController Class which contains major UI elements and functions.
class ViewController: UIViewController {
    // Array of views placed on main screen.
    @IBOutlet var views: [UIView]!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Action which handles press of button and invokes the change of views color.
    /// - Parameter sender: Sender argument.
    @IBAction func ChangeColorButtonPressed(_ sender: Any) {
        var colorsSet = createSetOfUniqueColors(from: views)
        
        // Button for views color change.
        let button = sender as? UIButton
        button?.isEnabled = false
        
        // Animation for process of color change.
        UIView.animate(withDuration: 1,
                       animations: {
            for view in self.views {
                view.layer.cornerRadius = 30
                view.backgroundColor = colorsSet.popFirst()
            }
        }) {
            completion in button?.isEnabled = true
        }
    }
    
    /// Creates set of unique UIColors for available views on the screen.
    /// - Parameter views: Array of views placed on the screen.
    /// - Returns: Set of unique UIColors.
    private func createSetOfUniqueColors(from views:[UIView]!) -> Set<UIColor> {
        var colorsSet = Set<UIColor>()
        
        while colorsSet.count < views.count {
            colorsSet.insert(
                generateUIColorFromHEX(from: generateHEXColorStringRepresentation())
            )
        }
        
        return colorsSet
    }
    
    /// Returns a special UIColor which is converted from random HEX string value.
    /// - Parameter hex: HEX string color
    /// - Returns: A converted UIColor from HEX string.
    private func generateUIColorFromHEX(from hex: String) -> UIColor {
        var modifiedColor: String = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        if (modifiedColor.hasPrefix("#")) {
            modifiedColor.remove(at: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: modifiedColor).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
    
    /// Returns a string representation of HEX color generated randomly.
    /// - Returns: A HEX color string representation generated from random chars.
    private func generateHEXColorStringRepresentation() -> String {
        let colorHEX: String = "#" + generateString(withLength: 6)
        
        return colorHEX
    }
    
    
    /// Creates a random generated string from Characters array with defined length.
    /// - Parameter length: Length of string to generate.
    /// - Returns: Random generated string with defined length.
    private func generateString(withLength length: Int) -> String {
        let availableChars: [Character] = [
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"
        ]
        
        var result: String = ""
        for _ in 0..<length {
            result += String(availableChars[.random(in: 0..<availableChars.count)])
        }
        
        return result
    }
}
