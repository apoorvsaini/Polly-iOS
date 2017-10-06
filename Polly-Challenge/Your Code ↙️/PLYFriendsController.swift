//
//  PLYFriendsController.swift
//  polly-challenge
//
//  Created by Vicc Alexander on 10/3/17.
//  Copyright © 2017 Polly Inc. All rights reserved.
//

import UIKit
import SnapKit

class PLYFriendsController: PLYController {

    //-----------------------------------
    // MARK: - Properties
    //-----------------------------------

    fileprivate var usersToAdd: [PLYUser] = []
    fileprivate var usersInContacts: [PLYUser] = []

    //-----------------------------------
    // MARK: - View Lifecycle
    //-----------------------------------

    override func viewDidLoad() {

        // Super
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {

        // Super
        super.viewDidAppear(animated)
        
        // Refresh users
        refreshUsers()
    }

    //-----------------------------------
    // MARK: - Setup View
    //-----------------------------------

    override func setupUI() {

        // Super
        super.setupUI()
        let cardView = self.cardView
        
        /*
         NOTE: Instead of adding your subviews to the controller's view, make sure to add them to cardView.
         - i.e. cardView.addSubview(yourView)
         */
        
        let mainView = UIScrollView()
        cardView?.addSubview(mainView)
        mainView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo((cardView?.snp.height)!)
            make.width.equalTo((cardView?.snp.width)!)
           
        }
        
        //pre-calcuate the height of sections
        let addSectionHeight : Int  = usersToAdd.count * 100
        let inviteSectionHeight : Int  = usersInContacts.count * 100
        
        //card UI for Add Friends section
        let addSection = UIView()
        mainView.addSubview(addSection)
        addSection.backgroundColor = UIColor.white
        addSection.layer.cornerRadius = 12
        addSection.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(addSectionHeight)
            make.top.equalTo((cardView?.snp.top)!).offset(50)
            make.right.equalTo((cardView?.snp.right)!).offset(-20)
        }
        
        let inviteSection = UIView()
        mainView.addSubview(inviteSection)
        inviteSection.backgroundColor = UIColor.white
        inviteSection.layer.cornerRadius = 12
        inviteSection.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(inviteSectionHeight)
            make.top.equalTo((cardView?.snp.top)!).offset(addSectionHeight + 100)
            make.right.equalTo((cardView?.snp.right)!).offset(-20)
        }
    

        //UI for each row in add view card
        var addCounter = 0
        for user in usersToAdd {
            let addCardRow = UIView()
            addSection.addSubview(addCardRow)
            print(addCounter * 100)
            addCardRow.snp.makeConstraints { (make) -> Void in
                make.centerX.equalToSuperview()
                make.height.equalTo(100)
                make.top.equalTo((addSection.snp.top)).offset(addCounter * 100).priority((addCounter * 10) + 1)
                make.right.equalTo((addSection.snp.right)).offset(0)
            }
            
            //add name label
            let adduserLabel = UILabel()
            addCardRow.addSubview(adduserLabel)
            adduserLabel.text = user.firstName!+" "+user.lastName!
            adduserLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            adduserLabel.textColor = UIColor.black
            adduserLabel.snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(addCardRow)
                make.left.equalTo(addCardRow.snp.left).inset(80)
            }
            
            //add user image
            let addUserImage = UIImageView()
            addCardRow.addSubview(addUserImage)
            addUserImage.image = user.avatar
            addUserImage.snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(addCardRow)
                make.height.equalTo(50)
                make.width.equalTo(50)
                make.left.equalTo(addCardRow.snp.left).inset(10)
            }
            
            //add "Add" button
            let addButton = UIButton()
            addCardRow.addSubview(addButton)
            addButton.setTitle("+ Add", for: .normal)
            addButton.backgroundColor = UIColor(red:0.00, green:0.76, blue:1.00, alpha:1.0)
            addButton.layer.cornerRadius = 20
            addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10.0)
            addButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
            addButton.snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(addCardRow)
                make.height.equalTo(40)
                make.width.equalTo(60)
                make.right.equalTo(addCardRow.snp.right).offset(-10)
            }
            addCounter += 1
        }
        
        
        //UI for each row in invite view card
        var inviteCounter = 0
        for user in usersInContacts {
            let inviteCardRow = UIView()
            inviteSection.addSubview(inviteCardRow)
            inviteCardRow.snp.makeConstraints { (make) -> Void in
                make.centerX.equalToSuperview()
                make.height.equalTo(100)
                make.top.equalTo((inviteSection.snp.top)).offset(inviteCounter * 100).priority((inviteCounter * 10) + 1)
                make.right.equalTo((inviteSection.snp.right)).offset(0)
            }
            
            //add name label
            let adduserLabel = UILabel()
            inviteCardRow.addSubview(adduserLabel)
            adduserLabel.text = user.firstName!+" "+user.lastName!
            adduserLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            adduserLabel.textColor = UIColor.black
            adduserLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(inviteCardRow.snp.top).inset(30).priority(10)
                make.left.equalTo(inviteCardRow.snp.left).inset(80)
            }
            
            //add phone label
            let phoneLabel = UILabel()
            inviteCardRow.addSubview(phoneLabel)
            phoneLabel.text = user.phoneNumber
            phoneLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            phoneLabel.textColor = UIColor(red:0.41, green:0.41, blue:0.41, alpha:1.0)
            phoneLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(inviteCardRow.snp.top).inset(50).priority(20)
                make.left.equalTo(inviteCardRow.snp.left).inset(80)
            }
            
            //add user image
            let addUserImage = UIImageView()
            inviteCardRow.addSubview(addUserImage)
            addUserImage.image = user.avatar
            addUserImage.snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(inviteCardRow)
                make.height.equalTo(50)
                make.width.equalTo(50)
                make.left.equalTo(inviteCardRow.snp.left).inset(10)
            }
            
            //add "Add" button
            let addButton = UIButton()
            inviteCardRow.addSubview(addButton)
            addButton.setTitle("+ Invite", for: .normal)
            addButton.backgroundColor = .clear
            addButton.layer.cornerRadius = 20
            addButton.layer.borderWidth = 2
            addButton.layer.borderColor = UIColor(red:0.41, green:0.41, blue:0.41, alpha:1.0).cgColor
            addButton.setTitleColor(UIColor(red:0.41, green:0.41, blue:0.41, alpha:1.0), for: .normal)
            addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10.0)
            addButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
            addButton.snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(inviteCardRow)
                make.height.equalTo(40)
                make.width.equalTo(60)
                make.right.equalTo(inviteCardRow.snp.right).offset(-10)
            }
            inviteCounter += 1
        }
        
    }

    //-----------------------------------
    // MARK: - Refreshing Data
    //-----------------------------------

    fileprivate func refreshUsers() {

        /* NOTE: On refresh the number of users for each array may change (Simulating real world updates). Make sure to account for this.*/

        // Update users
        usersToAdd = PLYManager.shared.quickAdds()
        usersInContacts = PLYManager.shared.invites()
        
        // Update the view here
        setupUI();
    }

    //-----------------------------------
    // MARK: - Memory Management
    //-----------------------------------

    override func didReceiveMemoryWarning() {

        // Super
        super.didReceiveMemoryWarning()
    }
}
