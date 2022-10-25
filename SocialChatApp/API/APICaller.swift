//
//  APICaller.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/25.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class APICaller
{
    static let shared = APICaller()
    
    
    func registerUSer(email: String,password:String ,imageURL: String ,fullname:String, username:String)
    {
        Auth.auth().createUser(withEmail: email, password: password) { (Results, Error) in
            if Error != nil
            {
                print("There was an Error while trying to Register user \(Error?.localizedDescription ?? "")")
            }else
            {
                print("User was registered Successfully\(Results?.user.email ?? "")")
                
                guard let uui = Results?.user.uid else { return }
                
                let data = ["email": email , "fullname":fullname , "profileImageUrl":imageURL,"uid": uui , "username": username] as [String:Any]
                
                Firestore.firestore().collection("USERS").document(uui).setData(data) { (Error) in
                    if Error != nil
                    {
                        print("There was an error while saving user informations into the datastore \(Error?.localizedDescription ?? "")")
                        return
                    }else
                    {
                        print("DEBUG: Did Create users")
                    }
                }
            }
        }
    }
    
}
