//
//  SliderSettiingsTableViewCell.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 06/02/2022.
//

import UIKit

class SliderSettiingsTableViewCell: UITableViewCell {

    static let identifier = "SliderSettiingsTableViewCell"
    
    private let title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 16, weight: .semibold)
        title.textColor = Constants.secondaryColor
        return title
    }()
    
    private let toggle: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
