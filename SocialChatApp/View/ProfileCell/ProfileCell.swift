//
//  ProfileCell.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/11/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

class ProfileCell: UITableViewCell
{
    //    MARK:- properties
    
    var profileviewmodell: ProfileHeadeViewModel?
      {
          didSet
          {
              configure()
          }
      }
    
    private let iconeImage: UIImageView =
    {
        let imageProfile = UIImageView()
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        imageProfile.clipsToBounds = true
        imageProfile.setDimensions(height: 40, width: 40)
        imageProfile.layer.cornerRadius = 40 / 2
        imageProfile.layer.borderColor = UIColor.white.cgColor
        imageProfile.tintColor = .white
        return imageProfile
    }()
    
    private lazy var iconview: UIView =
    {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconeImage)
        
        iconeImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iconeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.backgroundColor = .systemRed
        view.setDimensions(height: 50, width: 50)
        view.layer.cornerRadius = 50 / 2
        
        return view
    }()
    
    private let Account: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "Business Account"
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureProfile()
    }
    
    
    func configureProfile()
    {
        self.addSubview(iconview)
        iconview.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        self.addSubview(Account)
        Account.centerYAnchor.constraint(equalTo: iconeImage.centerYAnchor).isActive = true
        Account.leadingAnchor.constraint(equalTo: iconeImage.trailingAnchor, constant: 20).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure()
    {
        guard let viewmodel  = profileviewmodell else {return}
        self.iconeImage.image = UIImage(systemName: viewmodel.iconeImage)
        self.Account.text = viewmodel.description
    }
}
