//
//  NotesTableViewCell.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 10/02/2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    static let identifier = "NotesTableViewCell"
    
    private var model: NotesModel?
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 20)
        titleLabel.textColor = Constants.quaternaryColor
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        //bodyLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        bodyLabel.font = UIFont(name: "Courier", size: 15)
        bodyLabel.textColor = Constants.quaternaryColor
        bodyLabel.numberOfLines = 5
        bodyLabel.textAlignment = .left
        return bodyLabel
    }()
    
    private let noteTypeLabel: UILabel = {
        let noteTypeLabel = UILabel()
        noteTypeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        noteTypeLabel.textColor = Constants.quaternaryColor
        noteTypeLabel.textAlignment = .left
        return noteTypeLabel
    }()
    
    private let urgencyLabel: UILabel = {
        let urgencyLabel = UILabel()
        urgencyLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        urgencyLabel.textColor = .red
        return urgencyLabel
    }()
    
    private let doneByLabel: UILabel = {
        let doneByLabel = UILabel()
        doneByLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        doneByLabel.textColor = Constants.quaternaryColor
        doneByLabel.textAlignment = .left
        return doneByLabel
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Constants.tertiaryColor
        contentView.layer.borderColor = Constants.tertiaryColor.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 8.0
        backgroundColor = Constants.backgroundColor
        addSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size_width = frame.width/1.2
        let size_height = frame.height
        contentView.frame = CGRect(x: frame.midX - size_width/2,
                                   y: 20,
                                   width: size_width,
                                   height: size_height - 40)
        
        let titleHeight: CGFloat = CGFloat(titleLabel.numberOfLines) * 30
        titleLabel.frame = titleLabel.textRect(forBounds: CGRect(x: 10,
                                                                 y: 20,
                                                                 width: contentView.width - urgencyLabel.width - 50,
                                                                 height: titleHeight),
                                               limitedToNumberOfLines: 2)
        
        urgencyLabel.frame = CGRect(x: contentView.width - 45,
                                    y: 20,
                                    width: contentView.width/2 - 120,
                                    height: 25)
        
        let bodyHeight: CGFloat = CGFloat(bodyLabel.numberOfLines*15)
        
        bodyLabel.frame = bodyLabel.textRect(forBounds: CGRect(x: 10,
                                                               y: titleLabel.frame.maxY+5,
                                                               width: contentView.width-20,
                                                               height: bodyHeight),
                                             limitedToNumberOfLines: 5)
        
        doneByLabel.frame = CGRect(x: 10,
                                   y: contentView.height - 30,
                                   width: contentView.width/2,
                                   height: 20)
        
        noteTypeLabel.frame = CGRect(x: contentView.width - 80,
                                     y: contentView.height - 30,
                                     width: contentView.width/2 - 30,
                                     height: 20)
        

    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(noteTypeLabel)
        contentView.addSubview(urgencyLabel)
        contentView.addSubview(doneByLabel)
    }
    
    private func configureUrgencyLabel(urgency: Int) -> String {
        switch model?.urgency {
        case 1:
            return "!"
        case 2:
            return "!!"
        case 3:
            return "!!!"
        default:
            break
        }
        return "Urgency error"
    }
    
    public func configure(with model: NotesModel) {
        self.model = model
        titleLabel.text = model.title
        bodyLabel.text = model.body
        noteTypeLabel.text = model.note_type
        urgencyLabel.text = configureUrgencyLabel(urgency: model.urgency)
        
        if model.done_by_date.contains("T") {doneByLabel.text = DateUtil.shared.formatNoteDate(noteDate: model.done_by_date)}
        doneByLabel.text = model.done_by_date
    }
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        bodyLabel.text = nil
        noteTypeLabel.text = nil
        urgencyLabel.text = nil
        doneByLabel.text = nil
    }

}
