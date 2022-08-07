//
//  CustomNavigationBarController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 03/02/2022.
//

import Foundation
import UIKit

class CustomNavigationBar: UINavigationBar, UINavigationBarDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureNavBarAppearance()
    }
    
    
    private func configureNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.quaternaryColor]
        appearance.titleTextAttributes = [.foregroundColor: Constants.quaternaryColor]
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.backgroundColor
        self.standardAppearance = appearance
        self.compactAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
    
    
    
}


