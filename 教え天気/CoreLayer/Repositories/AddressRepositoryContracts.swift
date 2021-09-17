//
//  AddressRepositoryContracts.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import Foundation
import Combine

protocol AddressPublisher {
    func addressPub() ->  AnyPublisher<[String], Never>
}
