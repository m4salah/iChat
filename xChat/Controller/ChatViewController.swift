//
//  ChatViewController.swift
//  xChat
//
//  Created by Mohamed Abdelkhalek Salah on 5/9/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
            
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatTableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.tableCellId)
        
        navigationItem.title = Constants.appName
        navigationItem.hidesBackButton = true
        loadMessages()
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        if let message = messageTextField.text,
            message != "",
            let sender = Auth.auth().currentUser?.email {
            db.collection(Constants.collectionName).addDocument(data: [
                Constants.sender: sender,
                Constants.message: message,
                Constants.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let error = error {
                    print("error here1", error.localizedDescription)
                    self.showAlert(title: "Something Wrong", message: error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("error while logout", error.localizedDescription)
        }
    }
    
    fileprivate func updateUiAfterGettingMessages() {
        DispatchQueue.main.async {
            self.chatTableView.reloadData()
            self.chatTableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .top, animated: true)
        }
    }
    
    func handleLoadingMessage(_ query: [QueryDocumentSnapshot]){
        for doc in query {
            if let message = doc.data()[Constants.message] as? String,
                let sender = doc.data()[Constants.sender] as? String
            {
                let message = Message(sender: sender, message: message)
                self.messages.append(message)
                updateUiAfterGettingMessages()
            }
        }
    }

    func loadMessages() {
        db.collection(Constants.collectionName)
            .order(by: Constants.dateField)
            .addSnapshotListener { (query, error) in
            self.messages = []
            if let error = error {
                self.showAlert(title: "Something Wrong!", message: error.localizedDescription)
                self.navigationController?.popToRootViewController(animated: true)
                return
            }
            if let query = query?.documents {
                self.handleLoadingMessage(query)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableCellId, for: indexPath) as! MessageTableViewCell
        cell.configureUI(message: message)
        return cell
    }
}

