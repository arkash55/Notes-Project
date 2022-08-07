//
//  NewNoteViewController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 05/08/2022.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    private var newNote = NewNoteModel(user_id: nil,
                                       title: nil,
                                       body: nil,
                                       note_type: nil,
                                       urgency: nil,
                                       done_by_date: nil)
    
    public var completion: ((NotesModel) -> Void)?
    
    private var models = [SingleNoteModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SingleNoteTableViewCell.self, forCellReuseIdentifier: SingleNoteTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        configureNavigationBar()
        configureNoteData()
        configureTableView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //function
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
        navigationItem.title = "Create Note"
        let saveButton = UIBarButtonItem(title: "Save",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapSaveButton))
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        saveButton.setTitleTextAttributes([.font: font, .foregroundColor: Constants.secondaryColor],
                                          for: .normal)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureNoteData() {
        models.append(SingleNoteModel(title: "Title",
                                      value: nil))
        models.append(SingleNoteModel(title: "Body",
                                      value: nil))
        models.append(SingleNoteModel(title: "Urgency",
                                      value: nil))
        models.append(SingleNoteModel(title: "Type",
                                      value: nil))
        models.append(SingleNoteModel(title: "Done by Date",
                                      value: nil))
    }
    
    
    //@objc methods
    @objc private func didTapSaveButton() {
        print("did tap save")
        guard let user_id = UserDefaults.standard.value(forKey: "user_id") as? Int else {return}
        newNote.user_id = user_id
        
//        guard let finalNote = newNote else {
//            print("new note guard failed")
//            DispatchQueue.main.async {
//                AlertErrors.dismissError(vc: self, title: "Something went wrong...", message: "Please fill in all fields")
//            }
//            return
//        }

        
        DatabaseManager.shared.createNote(note: newNote) { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let note):
                DispatchQueue.main.async {
                    self?.dismiss(animated: true, completion: { [weak self] in
                        self?.completion?(note)
                    })
                }
            case .failure(let error):
                print("failed to make new note")
                print(error)
                DispatchQueue.main.async {
                    AlertErrors.dismissError(vc: strongSelf, title: "Something went wrong...", message: "Could not create note")
                }
            }
        }
    
    }
    


}




extension NewNoteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SingleNoteTableViewCell.identifier,
                                                 for: indexPath) as! SingleNoteTableViewCell
        let model = models[indexPath.row]
        cell.delegate = self
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



extension NewNoteViewController: NoteTextFieldDelegate {

    
    func didFinishUpdating(_ cell: SingleNoteTableViewCell, updatedModel: SingleNoteModel) {
        print("finished updating \(updatedModel.title)")
        cell.resignFirstResponder()
        
        if updatedModel.title == "Title" {
            newNote.title = updatedModel.value!
        } else if updatedModel.title == "Body" {
            newNote.body = updatedModel.value!
        } else if updatedModel.title == "Urgency" {
            newNote.urgency = Int(updatedModel.value!)
        } else if updatedModel.title == "Type" {
            newNote.note_type = updatedModel.value!
        } else if updatedModel.title == "Done by Date" {
            newNote.done_by_date = updatedModel.value!
        }
    }
    
    
}
