//
//  ProfileTableViewCell.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 16/01/2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    static let identifier = "ProfileTableViewCell"
    
    private let title: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 15, weight: .regular)
        title.textAlignment = .left
        return title
    }()
    
    private let value: UILabel = {
        let value = UILabel()
        value.textColor = .label
        value.textAlignment = .left
        value.font = .systemFont(ofSize: 15, weight: .regular)
        return value
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(value)
        contentView.backgroundColor = Constants.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = 10
        
        title.frame = CGRect(x: size,
                             y: size,
                             width: contentView.width/4,
                             height: contentView.height - size*2 )
        
        value.frame = CGRect(x: title.width + size + 15,
                             y: size,
                             width: contentView.width/2,
                             height: contentView.height - size*2)
        
    }
    
    
    
    
    //functions
    public func configureModels(with model: ProfileModel) {
        title.text = model.title
        value.text = model.value
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        value.text = nil
    }
    
    

}
