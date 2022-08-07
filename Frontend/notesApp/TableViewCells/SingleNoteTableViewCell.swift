//
//  SingleNoteTableViewCell.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 13/02/2022.
//

import UIKit

protocol NoteTextFieldDelegate: AnyObject {
    func didFinishUpdating(_ cell: SingleNoteTableViewCell, updatedModel: SingleNoteModel)
}

class SingleNoteTableViewCell: UITableViewCell {

    static let identifier = "SingleNoteTableViewCell"
    
    private var model: SingleNoteModel?
    public weak var delegate: NoteTextFieldDelegate?
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = Constants.quaternaryColor
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let valueField: UITextField = {
        let valueField = UITextField()
        valueField.textColor = Constants.quaternaryColor
        valueField.autocorrectionType = .no
        valueField.autocapitalizationType = .none
        valueField.leftViewMode = .always
        valueField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        valueField.backgroundColor = Constants.backgroundColor
        valueField.layer.borderColor = Constants.backgroundColor.cgColor
        valueField.layer.borderWidth = 1.0
        valueField.layer.masksToBounds = true
        return valueField
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Constants.backgroundColor
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueField)
        valueField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let y: CGFloat = 10
        titleLabel.frame = CGRect(x: 10,
                                  y: y,
                                  width: contentView.width/3 - 10,
                                  height: contentView.height - (2*y))
        
        valueField.frame = CGRect(x: titleLabel.frame.maxX + 10,
                                  y: y,
                                  width: contentView.width - contentView.width/3 - 20,
                                  height: contentView.height - (2*y))
        

        
        
        
        
    }
    
    public func configure(with model: SingleNoteModel) {
        self.model = model
        titleLabel.text = model.title
        valueField.placeholder = "Enter \(model.title)..."
        valueField.text = model.value
    }
    

    

}


extension SingleNoteTableViewCell: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        model?.value = text
        guard let model = model else {
            print("model failed")
            return
        }
        delegate?.didFinishUpdating(self, updatedModel: model)
    }
}
