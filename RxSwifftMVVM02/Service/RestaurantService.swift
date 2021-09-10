//
//  RestaurantService.swift
//  RxSwiftMVVM
//
//  Created by MacOS on 06/09/2021.
//

import UIKit
import RxSwift

class RestaurantService {
    func fetchRestaurants() -> Observable<[Restaurant]> {
        return Observable.create { observer -> Disposable in
            guard let path = Bundle.main.path(forResource: "restaurants", ofType: "json") else {
                return Disposables.create()
            }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
                print(restaurants)
                observer.onNext(restaurants)
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
