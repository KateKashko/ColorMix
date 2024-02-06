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

    
    @IBAction func firstViewButton(_ sender: Any) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
    
    @IBAction func secondViewButton(_ sender: Any) {
        
        
    }
    
    @IBAction func changeLanguageSC(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstViewColor.layer.cornerRadius = 15
        secondViewColor.layer.cornerRadius = 15
        resultViewColor.layer.cornerRadius = 15
    }
    
    func colorPickerViewControllerDidSelectColor(_ colorPicker: UIColorPickerViewController) {
        let selectedColor = colorPicker.selectedColor
        firstViewColor.backgroundColor = selectedColor
        firstColor.text = selectedColor.hexString
    }
}
extension UIColor {
    var hexString: String {
        guard let components = cgColor.components, components.count >= 3 else {
            return "FFFFFF"
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])

        let hexString = String(
            format: "%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)
        )

        return hexString
    }
}
