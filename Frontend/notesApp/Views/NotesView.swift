//
//  NotesView.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 10/02/2022.
//

import UIKit

class NotesView: UIView {
    
    private let emptyNotesImageView: UIImageView = {
        let emptyNotesImageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 33, weight: .medium, scale: .default)
        let image = UIImage(systemName: "hand.thumbsup")?.withTintColor(Constants.secondaryColor, renderingMode: .alwaysOriginal).withConfiguration(config)
        emptyNotesImageView.image = image
        return emptyNotesImageView
    }()
    
    private let emptyNotesLabel: UILabel = {
        let emptyNotesLabel = UILabel()
        emptyNotesLabel.text = "You have no notes"
        emptyNotesLabel.textColor = Constants.secondaryColor
        emptyNotesLabel.font = .systemFont(ofSize: 23, weight: .regular)
        emptyNotesLabel.textAlignment = .center
        return emptyNotesLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emptyNotesLabel)
        addSubview(emptyNotesImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = frame.width/2
        emptyNotesImageView.frame = CGRect(x: frame.width/2 - size/2,
                                           y: 5,
                                           width: size,
                                           height: size)
        
        let labelWidth = frame.width
        emptyNotesLabel.frame = CGRect(x: frame.width/2 - labelWidth/2,
                                       y: emptyNotesImageView.frame.maxY + 15,
                                       width: labelWidth,
                                       height: 25)
        
    }
    
}
