//
//  ViewController.swift
//  frestaurant
//
//  Created by Christianto Budisaputra on 14/05/21.
//

import UIKit

class Main: UIViewController {

  @IBOutlet weak var restaurantsTableView: UITableView!

  private let axios = Axios.shared
  var restaurants = [Restaurant]() {
    didSet {
      restaurantsTableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    getRestaurants()
  }

  private func getRestaurants() {
    axios.fetch(URL.restaurantList, type: RestaurantList.self) { result in
      switch result {
      case .success(let data):
        self.restaurants = data.restaurants
      case .failure(let err):
        print("Error:", err.localizedDescription)
      }
    }
  }

}

extension Main: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    restaurants.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
    cell.restaurant = restaurants[indexPath.row]
    return cell
  }
}
