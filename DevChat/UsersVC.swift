//
//  UsersVC.swift
//  DevChat
//
//  Created by PRO on 4/29/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var users = [Users]()
    var selectedUsers = Dictionary<String, Users>()
    
    private var _videoUrl: URL?
    
    var videoURL: URL {
        set {
            _videoUrl = newValue
        } get {
            return _videoUrl!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        sendButton.isEnabled = false

        DataService.instance.userRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject> {
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let user = Users(firstName: firstName, uid: uid)
                                self.users.append(user)
                                print(self.users)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func sendBtnPressed(sender: AnyObject) {
        print("sendButton pressed")
        spinner.isHidden = false
        spinner.startAnimating()
        let videoUrl = self._videoUrl
        let videoName = "\(NSUUID().uuidString)\(String(describing: videoUrl))"
        let ref = DataService.instance.videoStoreRef.child(videoName)
        self.dismiss(animated: true, completion: nil)
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        
        _ = ref.putFile(videoUrl!, metadata: nil, completion: { (metadata: FIRStorageMetadata?, error: Error?) in
            if error != nil {
                print("Error: \(error.debugDescription)")
            } else {
                
                let downloadUrl = metadata?.downloadURL()
//                print("\(downloadUrl)")
                DataService.instance.sendMedia(url: downloadUrl!, sender: (FIRAuth.auth()?.currentUser?.uid)!, sendingTo: self.selectedUsers)
//                DataService.instance.sendMediaPullRequest(sender: (FIRAuth.auth()?.currentUser?.uid)!, sendingTo: self.selectedUsers, mediaUrl: downloadUrl!)
//                print("Completed")
//                self.showAlert()
            }
        })
    }
    
    func showAlert() {
    let alert = UIAlertController(title: "Alert", message: "Wait Please!", preferredStyle: .alert)
    self.present(alert, animated: true, completion: nil)
    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.updateUI(user: users[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendButton.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count == 0 {
            sendButton.isEnabled = false
        }
    }
    
}
