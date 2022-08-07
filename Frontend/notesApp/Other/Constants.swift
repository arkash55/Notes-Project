//
//  Constants.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 17/12/2021.
//

import Foundation
import UIKit


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension UIView {
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }

}



struct Constants {
    static let cornerRadius: CGFloat = 15.0
    static let backgroundColor = UIColor(hexString: "#FAF3E0")
    static let secondaryColor = UIColor(hexString: "#B68973")
    static let tertiaryColor = UIColor(hexString: "#EABF9F")
    static let quaternaryColor = UIColor(hexString: "1E212D")
}


struct HttpMethods {
    static let post = "POST"
    static let get = "GET"
    static let delete = "DELETE"
    static let put = "PUT"
    static let patch = "PATCH"
}




class UnderlinedTextField: UITextField {
    
    private let underline = CALayer()
    
    //create and position the underline layer
    private func setUpLinelayer() {
        var frame = self.bounds
        frame.origin.y = frame.size.height-2
        frame.size.height = 2
        underline.frame = frame
        underline.backgroundColor = Constants.secondaryColor.cgColor
        
    }
    
    // In `init?(coder:)` Add our underlineLayer as a sublayer of the view's main layer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.addSublayer(underline)
    }

    // in `init(frame:)` Add our underlineLayer as a sublayer of the view's main layer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(underline)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLinelayer()
    }

    
}
