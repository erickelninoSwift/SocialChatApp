//
//  ProfileheaderView.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/11/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

protocol profileheaderViewDelegateaction: AnyObject {
    
    func dissmissprofileview()
}

class ProfileheaderView: UIView
{
    
    var delegate: profileheaderViewDelegateaction?
    
    var currentUser: User?
    {
        didSet
        {
            configure()
        }
    }
    
    //   MARK: = Properties
    
    
    private let dimismissButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.tintColor = .white
        button.setDimensions(height: 40, width: 40)
        button.addTarget(self, action: #selector(handleDimissbutton), for: .touchUpInside)
        return button
    }()
    
    private let profileImage: UIImageView =
    {
        let imageProfile = UIImageView()
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        imageProfile.clipsToBounds = true
        imageProfile.setDimensions(height: 200, width: 200)
        imageProfile.layer.cornerRadius = 200 / 2
        imageProfile.layer.borderWidth = 2
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.layer.borderColor = UIColor.white.cgColor
        imageProfile.backgroundColor = .lightGray
        return imageProfile
    }()
    
    private let username: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }()
    
    private let Fullname: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    //    MARK: - Life cycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientBackground()
        configuretheView()
    }
    
    
    func configuretheView()
    {
        self.addSubview(dimismissButton)
        dimismissButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        dimismissButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant:10).isActive = true
        
        self.addSubview(profileImage)
        
        profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 90).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        let stack = UIStackView(arrangedSubviews: [username,Fullname])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        self.addSubview(stack)
        stack.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //     MARK:- Functions
    
    
    @objc func handleDimissbutton()
    {
        delegate?.dissmissprofileview()
    }
    
    
    func gradientBackground()
    {
        let layerGradient = CAGradientLayer()
        layerGradient.colors = [UIColor.systemPink.cgColor,UIColor.systemRed.cgColor]
        layerGradient.locations = [0,1]
        self.layer.addSublayer(layerGradient)
        layerGradient.frame = bounds
    }
    
    
    func configure()
    {
        guard let myUser = currentUser else { return }
        guard let imageUrl = URL(string: myUser.profileImageUrl) else { return }
        profileImage.sd_setImage(with: imageUrl, completed: nil)
         let username = myUser.username
         let fullname = myUser.fullname
        
        self.username.text = username
        self.Fullname.text = "@\(fullname)"
    }
    
}
