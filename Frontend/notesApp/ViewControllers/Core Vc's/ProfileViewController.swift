//
//  ProfileViewController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 17/12/2021.
//

import UIKit

struct ProfileModel {
    let title: String
    let value: String
}

class ProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return tableView
    }()
    
    
    private var models = [ProfileModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(tableView)
        configureTableView(tableView)
        configureNavigationBar()
        configureNavBarAppearance()
        configureTableViewData()
        
     

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds

    }
    
    
    //functions
    private func configureTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Constants.backgroundColor
        tableView.tableHeaderView = configureTableHeaderView()
    }
    
    private func configureNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.quaternaryColor]
        appearance.titleTextAttributes = [.foregroundColor: Constants.quaternaryColor]
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium, scale: .medium)
        let gear = UIImage(systemName: "gear")?.withTintColor(Constants.secondaryColor, renderingMode: .alwaysOriginal).withConfiguration(config)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: gear,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    
    
    private func configureTableHeaderView() -> UIView? {
        let header_view = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/2.5))
        header_view.backgroundColor = Constants.backgroundColor
        let size = header_view.width/2.5
        let profilePicIcon = UIImageView(frame: CGRect(x: header_view.width/2 - size/2,
                                                       y: header_view.height/2 - size/2,
                                                       width: size,
                                                       height: size).integral)
        profilePicIcon.layer.cornerRadius = size/2
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold, scale: .default)
        let pic = UIImage(systemName: "person.circle")?.withTintColor(Constants.secondaryColor, renderingMode: .alwaysOriginal).withConfiguration(config)
        profilePicIcon.image = pic
        profilePicIcon.layer.borderWidth = 1.0
        profilePicIcon.layer.borderColor = Constants.secondaryColor.cgColor
        header_view.addSubview(profilePicIcon)
        return header_view
    }
    
    
    private func configureTableViewData() {
        guard let username = UserDefaults.standard.value(forKey: "username") as? String,
              let email = UserDefaults.standard.value(forKey: "email") as? String,
              let first_name = UserDefaults.standard.value(forKey: "first_name") as? String,
              let last_name = UserDefaults.standard.value(forKey: "last_name") as? String else {
                  return
              }
        models.append(ProfileModel(title: "Username",
                                   value: username))
        models.append(ProfileModel(title: "Email",
                                   value: email))
        models.append(ProfileModel(title: "First Name",
                                   value: first_name))
        models.append(ProfileModel(title: "Last Name",
                                   value: last_name))
    }

    
    
    //@objc methods
    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }



}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier,
                                                 for: indexPath) as! ProfileTableViewCell
        let model = models[indexPath.row]
        cell.configureModels(with: model)
        return cell
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let model = models[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}
