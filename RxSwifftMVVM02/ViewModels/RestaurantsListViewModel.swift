//
//  RestaurantsListViewModel.swift
//  RxSwiftMVVM
//
//  Created by MacOS on 06/09/2021.
//

import Foundation
import RxSwift

final class RestaurantsListViewModel {
    
    private let restaurantService = RestaurantService()
    
    func fetchRestaurantViewModels() -> Observable<[RestaurantViewModel]> {
        return restaurantService
            .fetchRestaurants()
            .map { $0.map {
                RestaurantViewModel(restaurant: $0)
            } }
    }
}
