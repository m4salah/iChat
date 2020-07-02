//
//  MessageTableViewCell.swift
//  xChat
//
//  Created by Mohamed Abdelkhalek Salah on 5/10/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import UIKit
import Firebase

class MessageTableViewCell: UITableViewCell {

    @IBOutlet var messageBodeView: UIView!
    @IBOutlet var messageBodyLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var youAvatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBodeView.layer.cornerRadius = messageBodeView.frame.size.height / 5
    }
    
    func configureSender(_ sender: Bool) {
        if sender {
            youAvatarImageView.isHidden = true
            avatarImageView.isHidden = false
            messageBodeView.backgroundColor = #colorLiteral(red: 0.9161835909, green: 0.4070937037, blue: 0.3199086487, alpha: 1)
        } else {
            youAvatarImageView.isHidden = false
            avatarImageView.isHidden = true
            messageBodeView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    func configureUI(message: Message) {
        configureSender(message.sender == Auth.auth().currentUser?.email!)
        messageBodyLabel.text = message.message
    }
}
