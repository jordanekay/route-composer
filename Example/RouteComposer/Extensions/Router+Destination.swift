//
// RouteComposer
// Router+Destination.swift
// https://github.com/ekazaev/route-composer
//
// Created by Eugene Kazaev in 2018-2022.
// Distributed under the MIT license.
//
// Become a sponsor:
// https://github.com/sponsors/ekazaev
//

import Foundation
import RouteComposer
import UIKit

/// Simple extension to support `Destination` instance directly by the `Router`.
extension Router {

    func navigate<ViewController: UIViewController, Context>(to step: DestinationStep<ViewController, Context>, with context: Context) throws {
        try navigate(to: step, with: context, animated: true, completion: nil)
    }

}
