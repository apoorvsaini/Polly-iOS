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
        
        
        //pre-calcuate the height of sections
        let addSectionHeight : Int  = usersToAdd.count * 100
        let inviteSectionHeight : Int  = usersInContacts.count * 100
        
        //card UI for Add Friends section
        let addSection = UIView()
        cardView?.addSubview(addSection)
        addSection.backgroundColor = UIColor.white
        addSection.layer.cornerRadius = 12
        addSection.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(addSectionHeight)
            make.top.equalTo((cardView?.snp.top)!).offset(50)
            make.right.equalTo((cardView?.snp.right)!).offset(-20)
        }
        
        let inviteSection = UIView()
        cardView?.addSubview(inviteSection)
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
            adduserLabel.text = user.firstName
            adduserLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            adduserLabel.textColor = UIColor.black
            adduserLabel.snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(addCardRow)
                make.left.equalTo(addCardRow.snp.left).inset(100)
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
            addCounter += 1
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
