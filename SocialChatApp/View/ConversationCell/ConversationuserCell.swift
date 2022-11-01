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
    
    
    var conversation: ConversationMessage?
    {
        didSet{configureConversationCell()}
    }
    
    
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
       
       private let latestMessageconversation: UILabel =
          {
              let label = UILabel()
              label.translatesAutoresizingMaskIntoConstraints = false
           label.textColor = .lightGray
              return label
          }()
       
    private let TimeStampMessage: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    
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
           
           let stack = UIStackView(arrangedSubviews: [username,latestMessageconversation])
           stack.translatesAutoresizingMaskIntoConstraints = false
           stack.axis = .vertical
           stack.spacing = 6
           self.addSubview(stack)
           
           stack.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 10).isActive = true
           stack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
          self.addSubview(TimeStampMessage)
        
        TimeStampMessage.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        TimeStampMessage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
    
       }
       
       func configureConversationCell()
       {
        guard let profileImageURL = URL(string: conversation?.user.profileImageUrl ?? "") else {return}
        guard let userName = conversation?.user.username else {return}
        guard let latestMessage = conversation?.message.text else {return}
        guard let date = conversation?.message.time.dateValue() else {return}
        let dateformatter = DateFormatter() 
        dateformatter.dateFormat = "hh:mm a"
       
        UserImage.sd_setImage(with: profileImageURL, completed: nil)
        username.text = userName
        latestMessageconversation.text = latestMessage
        TimeStampMessage.text = "\(dateformatter.string(from: date))"
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
