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

        
        //pre-calcuate the heights of sections
        let addSectionHeight : Int  = usersToAdd.count * 100
        let inviteSectionHeight : Int  = usersInContacts.count * 100
        
        
        //Add section header for Quick Add
        let addSectionHeader = UIView()
        cardView?.addSubview(addSectionHeader)
        addSectionHeader.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo((cardView?.snp.width)!)
            make.top.equalTo((cardView?.snp.top)!).offset(10)
        }
        
        
        //add section text in Add section header
        let addCardSectionText = UILabel()
        addSectionHeader.addSubview(addCardSectionText)
        addCardSectionText.text = "Quick Adds"
        if(usersToAdd.count == 0) {addCardSectionText.text = "No One To Add"}
        addCardSectionText.font = UIFont.boldSystemFont(ofSize: 16.0)
        addCardSectionText.textColor = UIColor.black
        addCardSectionText.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        
        //Add left right borders to section headers
        let leftAddBorder = UIView()
        addSectionHeader.addSubview(leftAddBorder)
        leftAddBorder.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
        leftAddBorder.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(addSectionHeader)
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(8)
            make.trailing.equalTo(addCardSectionText.snp.leadingMargin).offset(-20)
        }
        let rightAddBorder = UIView()
        addSectionHeader.addSubview(rightAddBorder)
        rightAddBorder.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
        rightAddBorder.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(addSectionHeader)
            make.height.equalTo(1)
            make.right.equalToSuperview().offset(-8)
            make.leading.equalTo(addCardSectionText.snp.trailingMargin).offset(20)
        }
        
        //card UI for Add Friends section
        let addSection = UIView()
        cardView?.addSubview(addSection)
        addSection.backgroundColor = UIColor.white
        addSection.layer.cornerRadius = 12
        addSection.layer.shadowColor = UIColor.black.cgColor
        addSection.layer.shadowOpacity = 0.05
        addSection.layer.shadowOffset =  CGSize(width: 0, height:4)
        addSection.layer.shadowRadius = 10
        addSection.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(addSectionHeight)
            make.top.equalTo((cardView?.snp.top)!).offset(80)
            make.right.equalTo((cardView?.snp.right)!).offset(-20)
        }
        
        //Section header for Invite
        let inviteSectionHeader = UIView()
        cardView?.addSubview(inviteSectionHeader)
        inviteSectionHeader.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo((cardView?.snp.width)!)
            make.top.equalTo((cardView?.snp.top)!).offset(addSectionHeight + 110)
        }
        
        //add section text in Invite section header
        let inviteSectionText = UILabel()
        inviteSectionHeader.addSubview(inviteSectionText)
        inviteSectionText.text = "In Your Contacts"
        if(usersInContacts.count == 0) {inviteSectionText.text = "No One To Invite"}
        inviteSectionText.font = UIFont.boldSystemFont(ofSize: 16.0)
        inviteSectionText.textColor = UIColor.black
        inviteSectionText.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        
        //Add left right borders to section headers
        let leftInviteBorder = UIView()
        inviteSectionHeader.addSubview(leftInviteBorder)
        leftInviteBorder.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
        leftInviteBorder.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(inviteSectionHeader)
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(8)
            make.trailing.equalTo(inviteSectionText.snp.leadingMargin).offset(-20)
        }
        let rightInviteBorder = UIView()
        inviteSectionHeader.addSubview(rightInviteBorder)
        rightInviteBorder.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
        rightInviteBorder.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(inviteSectionHeader)
            make.height.equalTo(1)
            make.right.equalToSuperview().offset(-8)
            make.leading.equalTo(inviteSectionText.snp.trailingMargin).offset(20)
        }
        
        
        //card UI for Invite Section
        let inviteSection = UIView()
        cardView?.addSubview(inviteSection)
        inviteSection.backgroundColor = UIColor.white
        inviteSection.layer.cornerRadius = 12
        inviteSection.layer.shadowColor = UIColor.black.cgColor
        inviteSection.layer.shadowOpacity = 0.05
        inviteSection.layer.shadowOffset =  CGSize(width: 0, height:4)
        inviteSection.layer.shadowRadius = 10
        inviteSection.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(inviteSectionHeight)
            make.top.equalTo((cardView?.snp.top)!).offset(addSectionHeight + 170)
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
            
            //add border
            if(addCounter < usersToAdd.count - 1) {
                let rowBorder = UIView()
                addCardRow.addSubview(rowBorder)
                rowBorder.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
                rowBorder.snp.makeConstraints { (make) -> Void in
                    make.centerX.equalTo(addCardRow)
                    make.height.equalTo(1)
                    make.width.equalTo(addCardRow.snp.width)
                    make.bottom.equalTo(addCardRow.snp.bottom)
                }
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
            
            //add border
            if(addCounter < usersInContacts.count - 1) {
                let rowBorder = UIView()
                inviteCardRow.addSubview(rowBorder)
                rowBorder.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
                rowBorder.snp.makeConstraints { (make) -> Void in
                    make.centerX.equalTo(inviteCardRow)
                    make.height.equalTo(1)
                    make.width.equalTo(inviteCardRow.snp.width)
                    make.bottom.equalTo(inviteCardRow.snp.bottom)
                }
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
