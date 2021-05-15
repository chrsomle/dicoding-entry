//
//  ViewController.swift
//  frestaurant
//
//  Created by Christianto Budisaputra on 14/05/21.
//

import UIKit

class Main: UIViewController {

  @IBOutlet weak var restaurantsTableView: UITableView!

  var selectedRestaurant: RestaurantBrief?

  private let axios = Axios.shared
  var restaurants = [RestaurantBrief]() {
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

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "seeDetail" {
      if let detail = segue.destination as? Detail {
        detail.restaurant = selectedRestaurant
      }
    }
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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedRestaurant = restaurants[indexPath.row]
    performSegue(withIdentifier: "seeDetail", sender: self)
  }
}
