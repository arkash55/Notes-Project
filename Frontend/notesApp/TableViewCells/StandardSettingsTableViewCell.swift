//
//  SettingsTableViewCell.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 06/02/2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    static let identifier = "SettingsTableViewCell"
    
    private var model: SettingCellModel?
    
    private let title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 16, weight: .semibold)
        title.textColor = Constants.secondaryColor
        return title
    }()
    
    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.tintColor = Constants.secondaryColor
        iconImageView.layer.masksToBounds = true
        return iconImageView
    }()
    
    
    private let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = Constants.secondaryColor
        return toggle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(toggle)
        contentView.addSubview(iconImageView)
        contentView.backgroundColor = Constants.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame = CGRect(x: 15,
                             y: 10,
                             width: contentView.width/2,
                             height: contentView.height - 20)
        
        guard let finalModel = model else {
            return
        }
        let x_postion: CGFloat = contentView.width - 65
        let imageSize: CGFloat = 40
        if finalModel.cellType == SettingCellType.standard {
            iconImageView.frame = CGRect(x: x_postion,
                                         y: 12.5,
                                         width: imageSize,
                                         height: imageSize)
            toggle.removeFromSuperview()
            
        } else if finalModel.cellType == SettingCellType.slider {
            toggle.frame = CGRect(x: x_postion,
                                  y: 17.5,
                                  width: 60,
                                  height: 30)
        }

        
    }
    

    
    
    public func configureWith(model: SettingCellModel) {
        self.model = model
        switch model.cellType {
        case .standard:
            title.text = model.title
            iconImageView.image = model.icon
        case .slider:
            title.text = model.title
        }
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        iconImageView.image = nil
    }
    
    
}
