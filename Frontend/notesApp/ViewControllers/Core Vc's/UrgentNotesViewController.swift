//
//  FriendsViewController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 03/02/2022.
//

import UIKit

class UrgentNotesViewController: UIViewController {
    
    private var models = [NotesModel]()
    
    private var hasFetched = false
    
    private let emptyNotesView: NotesView = {
        let emptyNotesView = NotesView()
        emptyNotesView.isHidden = true
        return emptyNotesView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifier)
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(tableView)
        view.addSubview(emptyNotesView)
        configureTableView(tableView)
        configureTableViewData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        configureTableViewData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        let size = view.width
        emptyNotesView.frame = CGRect(x: view.width/2 - size/2,
                                      y: view.height/2 - size/2,
                                      width: size,
                                      height: size)
    }
    
    
    
    //functions

    private func configureTableView(_ tableview: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Constants.backgroundColor
    }
    
    
    
    private func configureTableViewData() {
        guard hasFetched == false else {return}
        //get request
        DatabaseManager.shared.getUserUrgentNotes{ [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let notesData):
                self?.hasFetched = true
                if notesData.isEmpty {
                    DispatchQueue.main.async {
                        self?.tableView.isHidden = true
                        self?.emptyNotesView.isHidden = false
                    }
                } else {
                    self?.models = notesData
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.tableView.isHidden = false
                        self?.emptyNotesView.isHidden = true
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    AlertErrors.dismissError(vc: strongSelf,
                                             title: "Something Went wrong",
                                             message: "Could not get notes data")
                }
                print(error)
                return
            }
        }
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Urgent Notes"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    



}



extension UrgentNotesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier,
                                                 for: indexPath) as! NotesTableViewCell
        let model = models[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height*0.3
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let model = models[indexPath.row]
        let vc = NoteViewController(note_id: model.id,
                                    note_title: model.title,
                                    body: model.body,
                                    urgency: model.urgency,
                                    type: model.note_type,
                                    done_by_date: model.done_by_date)
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true, completion: nil)
        
        
    }
    

}


