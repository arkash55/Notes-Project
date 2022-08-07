//
//  SettingsViewController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 16/01/2022.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SettingsTableViewCell.self,
                           forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[SettingCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        configureNavigationBar()
        configureTableView()
        configureTableViewData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Constants.quaternaryColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: Constants.quaternaryColor]
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.title = "Settings"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold, scale: .default)
        let backButtonImage = UIImage(systemName: "chevron.backward")?.withTintColor(Constants.secondaryColor,
                                                                                     renderingMode: .alwaysOriginal).withConfiguration(config)
        let backButton = UIBarButtonItem(image: backButtonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Constants.backgroundColor
        view.addSubview(tableView)
    }
    
    
    private func configureTableViewData() {
        models.append([
            SettingCellModel(title: "Dark Mode", icon: nil, cellType: .slider, handler: nil),
            SettingCellModel(title: "Invite Friends", icon: UIImage(systemName: "person.fill.badge.plus"), cellType: .standard, handler: nil),
            SettingCellModel(title: "Storage Usage", icon: UIImage(systemName: "folder.fill.badge.person.crop"), cellType: .standard, handler: nil)
        ])
        
        models.append([
            SettingCellModel(title: "Location Tracking", icon: nil, cellType: .slider, handler: nil),
            SettingCellModel(title: "Terms Of Service",
                             icon: UIImage(systemName: "book.circle"),
                             cellType: .standard,
                             handler: { [weak self] in
                                 self?.openUrl(urlType: .terms)
                             }),
            SettingCellModel(title: "Privacy Policy",
                             icon: UIImage(systemName: "hand.raised.fill"),
                             cellType: .standard,
                             handler: { [weak self] in
                                 self?.openUrl(urlType: .privacy)
                             })
        ])
        
        models.append([SettingCellModel(title: "Log Out",
                                        icon: UIImage(systemName: "arrowshape.zigzag.right.fill"),
                                        cellType: .standard,
                                        handler: { [weak self] in
                                        self?.logOut()
                             })])
        
    }
    
    enum SettingCellUrlType {
        case terms
        case privacy
    }
    
    private func openUrl(urlType: SettingCellUrlType) {
        var urlString = ""
        switch urlType {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/519522125107875"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    private func logOut() {
        let actionSheet = UIAlertController(title: "Sign Out",
                                            message: "Are you sure you want to sign out?",
                                            preferredStyle: .actionSheet)


        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))

        actionSheet.addAction(UIAlertAction(title: "Sign Out",
                                      style: .destructive,
                                      handler: { [weak self] _ in
            AuthManager.shared.logOut { [weak self] result in
                switch result {
                case .success(_):
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    DispatchQueue.main.async {
                        self?.navigationController?.popToRootViewController(animated: true)
                        self?.tabBarController?.selectedIndex = 1
                        let vc = LoginViewController()
                        let navVc = UINavigationController(rootViewController: vc)
                        self?.present(navVc, animated: true, completion: nil)
                    }
                case .failure(let error):
                    print(error)
                    guard let strongSelf = self else {
                        return
                    }
                    AlertErrors.dismissError(vc: strongSelf, title: "Something went wrong", message: "Could not sign out user")
                }
            }
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    //@objc methods
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    



}



extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier,
                                                 for: indexPath) as! SettingsTableViewCell
        let model = models[indexPath.section][indexPath.row]
        cell.configureWith(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.section][indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        model.handler?()
    }
    

}
