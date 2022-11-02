//
//  FooterView.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/11/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

protocol dimisprofileViewDelegate: AnyObject {
    func dimsisslogout()
}
class FooterView: UIView
{
    
    
    var delegate:dimisprofileViewDelegate?
    
    
    private let logoutButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .systemPink
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(logoutButton)
        logoutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        logoutButton.setHeight(height: 50)
        logoutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleLogout()
    {
        delegate?.dimsisslogout()
    }
}
