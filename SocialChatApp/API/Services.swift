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
          COLLECTION_USERS.getDocuments { (snapshots, Error) in
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
    
//    send to user messages and set message to both users database fields
    
    func uploadMessage(message: String , toUser: User, completion: ((Error?) -> Void)?)
    {
        guard let currentUserid = Auth.auth().currentUser?.uid else {return}
        
        let data = ["text": message , "toId": toUser.uuid ,"fromId": currentUserid, "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("Messages").document(currentUserid).collection(toUser.uuid).addDocument(data: data) { _ in
            
            Firestore.firestore().collection("Messages").document(toUser.uuid).collection(currentUserid).addDocument(data: data) { _ in
                
                COLLECTION_MESSAGES.document(currentUserid).collection("recent-messages").document(toUser.uuid).setData(data)
                COLLECTION_MESSAGES.document(toUser.uuid).collection("recent-messages").document(currentUserid).setData(data)
            }
        }
        
    }
    
    
    func retreiveMessagesFromDatabase(forUser: User,completion: @escaping(Result<[Message],Error>) -> Void)
    {
        
        var collectedMessages = [Message]()
        
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(currentUserId).collection(forUser.uuid).order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, Error) in
            
            if let error  = Error
            {
                completion(.failure(error))
                return
            }
            snapshot?.documentChanges.forEach({ (documentChange) in
                
                if documentChange.type == .added
                {
                    let dictonary = documentChange.document.data()
                    collectedMessages.append(Message(userdata: dictonary))
                    completion(.success(collectedMessages))
                 
                }
            })
        }
        

    }
    
    
    func getCurrentUserInteraction(completion: @escaping(Result<[ConversationMessage],Error>) -> Void)
    {
        var conversation = [ConversationMessage]()
        
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        
        let Query = COLLECTION_MESSAGES.document(currentUser).collection("recent-messages").order(by: "timestamp")
        
        Query.addSnapshotListener { (snapshot, Error) in
            if let error = Error
            {
                print("There was an error while trying to collect messaages \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            snapshot?.documentChanges.forEach({ (changes) in
                let dictionary = changes.document.data()
                let message = Message(userdata: dictionary)
                self.fetchUser(withUID: message.toID) { User in
                    
                    let myconversation  = ConversationMessage(user: User, message: message)
                    conversation.append(myconversation)
                    completion(.success(conversation))
                }
            })
        }
    }
    
    func fetchUser(withUID: String , completion: @escaping(User) -> Void)
    {
        COLLECTION_USERS.document(withUID).getDocument { (snapshot, Error) in
            if let error  = Error
            {
                print("There was an erro while fetching users \(error.localizedDescription)")
                
            }else
            {
                guard let dictionary = snapshot?.data() else { return }
                let user  = User(userdata: dictionary)
                completion(user)
            }
        }
    }
    
}
