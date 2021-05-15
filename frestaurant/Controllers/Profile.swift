//
//  Profile.swift
//  frestaurant
//
//  Created by Christianto Budisaputra on 15/05/21.
//

import UIKit

class Profile: UIViewController {

  @IBOutlet weak var profilePicture: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
  }

}
