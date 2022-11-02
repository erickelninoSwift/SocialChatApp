//
//  ProfileVoewController.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/11/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewwController: UITableViewController
{
    
    
    private let CELL_ID_PROFILE = "ProfileViewwController"
    //    MARK: - properties
    
    private lazy var headerView = ProfileheaderView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    
    private lazy var footView = FooterView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITableView()
        headerView.delegate = self
        footView.delegate = self
        tableView.rowHeight = 70
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        tableView.contentInsetAdjustmentBehavior = .never
        fetchuserinfo()
    }
    func configureUITableView()
    {
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableHeaderView = headerView
        tableView.register(ProfileCell.self, forCellReuseIdentifier: CELL_ID_PROFILE)
        tableView.tableFooterView = footView

    }
    
    
    //    MARK: - functions
    
    
    
}

//MARK: = tableview functions

extension ProfileViewwController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileHeadeViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID_PROFILE, for: indexPath) as? ProfileCell else
        { return UITableViewCell()}
        let profilemodel = ProfileHeadeViewModel(rawValue: indexPath.row)
        cell.profileviewmodell = profilemodel
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func fetchuserinfo()
    {
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        Services.shared.fetchUser(withUID: currentUserId) { User in
            self.headerView.currentUser = User
        }
    }
   
}

extension ProfileViewwController
{
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension ProfileViewwController: profileheaderViewDelegateaction
{
    func dissmissprofileview() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension ProfileViewwController: dimisprofileViewDelegate
{
    func dimsisslogout() {
        do
        {
            try Auth.auth().signOut()
            let controller = LoginViewController()
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }catch
        {
            print("DEBUG: there was an erro while trying to singout")
        }
    }
}
