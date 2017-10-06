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
        
        
        //calcuate the width of sections
        
        
        //section card UI
        let section = UIView()
        cardView?.addSubview(section)
        section.backgroundColor = UIColor.white
        section.layer.cornerRadius = 12
        section.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalTo((cardView?.snp.top)!).offset(50)
            make.right.equalTo((cardView?.snp.right)!).offset(-20)
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
