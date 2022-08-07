//
//  HomeViewController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 17/12/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
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
        handleAuthentication()
        configureNavigationBar()
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(tableView)
        view.addSubview(emptyNotesView)
        configureTableView(tableView)
        configureTableViewData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        handleAuthentication()
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
    
    
    
    //FUNCTIONS
    ///check if there is a user
    private func handleAuthentication() {
        if UserDefaults.standard.value(forKey: "user_id") != nil {
            return
        }
        let vc = LoginViewController()
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: false, completion: nil)
    }
    
    private func configureTableView(_ tableview: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTableViewData() {
        guard hasFetched == false else {return}
        //get request
        DatabaseManager.shared.getUserNotes { [weak self] result in
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "American Typewriter Bold", size: 36), size: 36)]
        appearance.titleTextAttributes = [.foregroundColor: Constants.quaternaryColor, .font: UIFont.systemFont(ofSize: 18)]
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.quaternaryColor, .font: UIFont.systemFont(ofSize: 24, weight: .semibold)]
        appearance.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        

        guard let navTitle = configureTitleText() else {
            return
        }
        navigationItem.title = navTitle
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        let config = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold, scale: .default)
        let createNoteImage = UIImage(systemName: "plus.square")?.withTintColor(Constants.secondaryColor, renderingMode: .alwaysOriginal).withConfiguration(config)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: createNoteImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCreateNoteButton))
    }
    
    private func configureTitleText() -> String? {
        guard let username = UserDefaults.standard.value(forKey: "username") as? String else {
            return nil
        }
        let hour = Calendar.current.component(.hour, from: Date())
        var prefix: String = ""
        switch hour {
        case 6..<12:
            prefix = "Morning"
        case 12..<18:
            prefix = "Afternoon"
        case 18..<20:
            prefix = "Evening"
        default:
            prefix = "Night"
        }
        let titleText = "Good \(prefix), \(username)"
        return titleText
    }
    
    
    //@objc methods
    @objc private func didTapCreateNoteButton() {
        let vc = NewNoteViewController()
        vc.completion = {   [weak self] newNote in
            self?.models.insert(newNote, at: 0)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .popover
        present(navVc, animated: true, completion: nil)
    }
    

}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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
