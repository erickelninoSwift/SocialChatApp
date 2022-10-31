//
//  ConversationuserCell.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/31.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class ConversationuserCell: UITableViewCell
{
    
    
    
     private let UserImage: UIImageView =
       {
           let Imageprofile = UIImageView()
           Imageprofile.translatesAutoresizingMaskIntoConstraints = false
           Imageprofile.clipsToBounds = true
           Imageprofile.setDimensions(height: 70, width: 70)
           Imageprofile.layer.cornerRadius = 70 / 2
           Imageprofile.contentMode = .scaleAspectFill
       
           
           return Imageprofile
       }()
       
       private let username: UILabel =
       {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textColor = .black
           label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
           return label
       }()
       
       private let fullname: UILabel =
          {
              let label = UILabel()
              label.translatesAutoresizingMaskIntoConstraints = false
           label.textColor = .lightGray
              return label
          }()
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           configureCell()
       }
       
       func configureCell()
       {
           self.addSubview(UserImage)
           UserImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
           UserImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
           
           let stack = UIStackView(arrangedSubviews: [username,fullname])
           stack.translatesAutoresizingMaskIntoConstraints = false
           stack.axis = .vertical
           stack.spacing = 6
           self.addSubview(stack)
           
           stack.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 10).isActive = true
           stack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
           
           
       }
       
       func cellData()
       {
        
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
