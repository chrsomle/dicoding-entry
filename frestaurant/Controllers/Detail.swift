//
//  Detail.swift
//  frestaurant
//
//  Created by Christianto Budisaputra on 14/05/21.
//

import UIKit

class Detail: UIViewController {

  let axios = Axios.shared

  @IBOutlet weak var restaurantAddress: UILabel!
  @IBOutlet weak var restaurantRating: UILabel!
  @IBOutlet weak var restaurantPicture: UIImageView!
  @IBOutlet weak var menuList: UITableView!
  @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!

  var menuHeight: CGFloat {
    menuList.layoutIfNeeded()
    return menuList.contentSize.height
  }

  var restaurant: RestaurantBrief?
  var detail: Restaurant? {
    didSet {
      guard let detail = detail else { return }
      self.restaurantAddress.text = "📍 \(detail.address), \(detail.city)"
      axios.fetch(URL.restaurantImageMedium + detail.pictureID) { result in
        switch result {
        case .success(let data):
          self.restaurantPicture.image = UIImage(data: data)
        case .failure(let err):
          print("Error:", err.localizedDescription)
        }
      }
      menus = [detail.menus.foods, detail.menus.drinks]
      menuList.reloadData()
      menuHeightConstraint.constant = menuHeight
    }
  }

  var headerTitles = ["🍔 Foods", "🍺 Drinks"]
  var menus =  [[Category]]()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupData()
  }

  private func setupData() {
    if let restaurant = restaurant {
      title = restaurant.name
      restaurantRating.text = restaurant.rating.toRating()
      axios.fetch(URL.restaurantDetail + restaurant.id, type: RestaurantDetail.self) { result in
        switch result {
        case .success(let data):
          self.detail = data.restaurant
        case .failure(let err):
          print("Error:", err.localizedDescription)
        }
      }
    }
  }

}

extension Detail: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    menus.count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    section < headerTitles.count ? headerTitles[section] : nil
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    menus[section].count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuCell
    cell.textLabel?.text = menus[indexPath.section][indexPath.row].name
    return cell
  }

}
