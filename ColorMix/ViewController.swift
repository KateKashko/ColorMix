//
//  ViewController.swift
//  ColorMix
//
//  Created by Kate Kashko on 5.02.2024.
//

import UIKit

class ViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    @IBOutlet weak var firstColor: UILabel!
    @IBOutlet weak var secondColor: UILabel!
    @IBOutlet weak var resultColor: UILabel!
    
    @IBOutlet weak var firstViewColor: UIView!
    @IBOutlet weak var secondViewColor: UIView!
    @IBOutlet weak var resultViewColor: UIView!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var languageSC: UISegmentedControl!
    
    var selectedColorView: UIView?
    var selectedColorLabel: UILabel?
    
    var language: Language = .english {
        didSet {
            updateLanguage()
        }
    }
    
    enum Language: Int {
        case english
        case russian
    }
    
    @IBAction func firstViewButton(_ sender: UIButton) {
        selectedColorView = firstViewColor
        selectedColorLabel = firstColor
        presentColorPicker()
    }
    
    @IBAction func secondViewButton(_ sender: UIButton) {
        selectedColorView = secondViewColor
        selectedColorLabel = secondColor
        presentColorPicker()
    }
    
    @IBAction func changeLanguageSC(_ sender: UISegmentedControl) {
        if let selectedLanguage = Language(rawValue: sender.selectedSegmentIndex) {
            language = selectedLanguage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstViewColor.layer.cornerRadius = 15
        secondViewColor.layer.cornerRadius = 15
        resultViewColor.layer.cornerRadius = 15
        updateLanguage()
    }
    
    func updateLanguage() {
        switch language {
        case .english:
            firstColor.text = "First Color"
            secondColor.text = "Second Color"
            resultColor.text = "Result Color"
        case .russian:
            firstColor.text = NSLocalizedString("Первый цвет", comment: "")
            secondColor.text = NSLocalizedString("Второй цвет", comment: "")
            resultColor.text = NSLocalizedString("Результат", comment: "")
        }
    }
    
    func presentColorPicker() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        guard let selectedColorView = selectedColorView, let selectedColorLabel = selectedColorLabel else {
            return
        }
        
        let selectedColor = viewController.selectedColor
        selectedColorView.backgroundColor = selectedColor
        selectedColorLabel.text = selectedColor.accessibilityName
        
        if let firstColor = firstViewColor.backgroundColor,
           let secondColor = secondViewColor.backgroundColor {
            if let blendedColor = blendColors(color1: firstColor, color2: secondColor) {
                resultViewColor.backgroundColor = blendedColor
                resultColor.text = blendedColor.accessibilityName
            } else {
                resultColor.text = "unable"
            }
        }
    }
    func blendColors(color1: UIColor, color2: UIColor) -> UIColor? {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let blendedRed = (r1 + r2) / 2
        let blendedGreen = (g1 + g2) / 2
        let blendedBlue = (b1 + b2) / 2
        
        let blendedColor = UIColor(red: blendedRed, green: blendedGreen, blue: blendedBlue, alpha: 1.0)
        
        return blendedColor
    }
}


//extension UIColor {
//    var hexString: String {
//        guard let components = cgColor.components, components.count >= 3 else {
//            return "FFFFFF"
//        }
//        
//        let r = Float(components[0])
//        let g = Float(components[1])
//        let b = Float(components[2])
//        
//        let hexString = String(
//            format: "%02lX%02lX%02lX",
//            lroundf(r * 255),
//            lroundf(g * 255),
//            lroundf(b * 255)
//        )
//        
//        return hexString
//    }
//}

//label.text = color.accessibilityName.localizedUppercase
