//
//  Networking.swift
//  frestaurant
//
//  Created by Christianto Budisaputra on 14/05/21.
//

import Foundation

struct Axios {
  static let shared = Axios()
  private let session = URLSession(configuration: .default)

  func fetch<T: Decodable>(_ url: String, type: T.Type, handler: @escaping (Result<T, Error>) -> Void) {
    let url = URL(string: url)!
    session.dataTask(with: url) { (data, res, err) in
      if err != nil { handler(.failure(err!)); return }
      guard let rawData = data else { fatalError("Error occured while parsing the data!") }
      do {
        let data = try JSONDecoder().decode(T.self, from: rawData)
        DispatchQueue.main.async {
          handler(.success(data))
        }
      } catch { handler(.failure(error)) }
    }.resume()
  }

  func fetch(_ url: String, handler: @escaping (Result<Data, Error>) -> Void) {
    let url = URL(string: url)!
    session.downloadTask(with: url) { (localUrl, res, err) in
      if err != nil { handler(.failure(err!)); return }
      guard let rawData = localUrl else { fatalError("Error occured while parsing the data!") }
      do {
        let data = try Data(contentsOf: rawData)
        DispatchQueue.main.async {
          handler(.success(data))
        }
      } catch {
        handler(.failure(error))
      }
    }.resume()
  }

}
