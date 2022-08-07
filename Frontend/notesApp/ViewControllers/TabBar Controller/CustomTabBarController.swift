//
//  CustomTabBarController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 03/02/2022.
//

import Foundation
import UIKit


class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureHomeButton()
        configureTabBar()
        self.selectedIndex = 1
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //functions
    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.backgroundColor
        tabBar.scrollEdgeAppearance = appearance
        tabBar.standardAppearance = appearance
        tabBar.tintColor = Constants.secondaryColor
        tabBar.unselectedItemTintColor = .white
    }

    
    
    
    private func configureHomeButton() {
        
        let size = view.frame.size.width/5
        let homeButton = UIButton(frame: CGRect(x: view.width/2 - size/2,
                                                y: -40,
                                                width: size,
                                                height: size))
        homeButton.layer.cornerRadius = size/2

        
        homeButton.setBackgroundImage(UIImage(named: "home-icon.png"), for: .normal)
        homeButton.layer.shadowColor = UIColor.black.cgColor
        homeButton.layer.shadowOpacity = 0.1
        homeButton.layer.shadowOffset = CGSize(width: 8, height: 8)
        
        self.tabBar.addSubview(homeButton)
        self.view.layoutIfNeeded()
        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .allTouchEvents)
    }
    
    
    //@objc methods
    @objc private func didTapHomeButton(_ button: UIButton) {
        self.selectedIndex = 1
    }
    
    
}



