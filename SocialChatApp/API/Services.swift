//
//  Services.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/28.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import Foundation
import Firebase

class Services
{
    static let shared = Services()
    
    func fetchAllusers(completion : @escaping(Result<User,Error>) -> Void)
    {
        Firestore.firestore().collection("USERS").getDocuments { (snapshots, Error) in
            if Error != nil
            {
                print("DEBUG: there was an error while trying to get all users data \(Error!.localizedDescription)")
                completion(.failure(Error!))
              
            }else
            {
                guard let userdata = snapshots?.documents else {return}
                
                userdata.forEach { (documents) in
                    
                    let userdata  = documents.data() as [String:Any]
                    
                    let currentUser = User(userdata: userdata)
                    completion(.success(currentUser))
                }
                
            }
        }
    }
    
}
