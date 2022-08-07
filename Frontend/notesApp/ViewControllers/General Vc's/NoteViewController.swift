//
//  NewNoteViewController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 13/02/2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    private var note_id: Int
    private var note_title: String
    private var body: String
    private var urgency: Int
    private var type: String
    private var done_by_date: String

    
    private var models = [SingleNoteModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SingleNoteTableViewCell.self, forCellReuseIdentifier: SingleNoteTableViewCell.identifier)
        return tableView
    }()
    
    
    init(note_id: Int, note_title: String, body: String, urgency: Int, type: String, done_by_date: String) {
        self.note_id = note_id
        self.note_title = note_title
        self.body = body
        self.urgency = urgency
        self.type = type
        self.done_by_date = done_by_date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        configureNavigationBar()
        configureTableView()
        configureNoteData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: Constants.quaternaryColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.quaternaryColor]
        appearance.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = self.note_title
        let config = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold, scale: .default)
        let backIcon = UIImage(systemName: "chevron.backward")?.withTintColor(Constants.secondaryColor,
                                                                              renderingMode: .alwaysOriginal).withConfiguration(config)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backIcon,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapBackButton))
        
        
        let saveButton = UIBarButtonItem(title: "Save",
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapSaveButton))
        
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        saveButton.setTitleTextAttributes([.font: font, .foregroundColor: Constants.secondaryColor],
                                          for: .normal)
                
        navigationItem.rightBarButtonItem = saveButton

    
        
            //figure out how to get two line navigation title
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Constants.backgroundColor
    }
    
    
    private func configureNoteData() {
        models.append(SingleNoteModel(title: "Title",
                                      value: note_title))
        models.append(SingleNoteModel(title: "Body",
                                      value: body))
        models.append(SingleNoteModel(title: "Urgency",
                                      value: "\(urgency)"))
        models.append(SingleNoteModel(title: "Type",
                                      value: type))
        models.append(SingleNoteModel(title: "Done by Date",
                                      value: DateUtil.shared.formatNoteDate(noteDate: done_by_date)))
       // models.append(SingleNoteModel(title: "Created at Date",value: created_at_date))
    }

    
    //@objc methods
    @objc private func didTapBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapSaveButton() {
        print(note_title)
    }
    


}


extension NoteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SingleNoteTableViewCell.identifier,
                                                 for: indexPath) as! SingleNoteTableViewCell
        let model = models[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
