//
// RouteComposer
// Router.swift
// https://github.com/ekazaev/route-composer
//
// Created by Eugene Kazaev in 2018-2022.
// Distributed under the MIT license.
//
// Become a sponsor:
// https://github.com/sponsors/ekazaev
//

import Foundation
import UIKit

/// Base router protocol.
public protocol Router {

    // MARK: Methods to implement

    /// Navigates the application to the view controller configured in `DestinationStep` with the `Context` provided.
    ///
    /// - Parameters:
    ///   - step: `DestinationStep` instance.
    ///   - context: `Context` instance.
    ///   - animated: if true - the navigation should be animated where it is possible.
    ///   - completion: completion block.
    func navigate<ViewController: UIViewController, Context>(to step: DestinationStep<ViewController, Context>,
                                                             with context: Context,
                                                             animated: Bool,
                                                             completion: ((_: RoutingResult) -> Void)?) throws

}

// MARK: Helper methods

public extension Router {

    /// Navigates the application to the view controller configured in `DestinationStep` with the `Context` set to `Any?`.
    ///
    /// - Parameters:
    ///   - step: `DestinationStep` instance.
    ///   - animated: if true - the navigation should be animated where it is possible.
    ///   - completion: completion block.
    func navigate<ViewController: UIViewController>(to step: DestinationStep<ViewController, Any?>,
                                                    animated: Bool,
                                                    completion: ((_: RoutingResult) -> Void)?) throws {
        try navigate(to: step, with: nil, animated: animated, completion: completion)
    }

    /// Navigates the application to the view controller configured in `DestinationStep` with the `Context` set to `Void`.
    ///
    /// - Parameters:
    ///   - step: `DestinationStep` instance.
    ///   - animated: if true - the navigation should be animated where it is possible.
    ///   - completion: completion block.
    func navigate<ViewController: UIViewController>(to step: DestinationStep<ViewController, Void>,
                                                    animated: Bool,
                                                    completion: ((_: RoutingResult) -> Void)?) throws {
        try navigate(to: step, with: (), animated: animated, completion: completion)
    }

}

// MARK: Navigation without the exception throwing

public extension Router {

    /// Navigates the application to the view controller configured in `DestinationStep` with the `Context` provided.
    /// Method does not throw errors, but propagates them to the completion block
    ///
    /// - Parameters:
    ///   - step: `DestinationStep` instance.
    ///   - context: `Context` instance.
    ///   - animated: if true - the navigation should be animated where it is possible.
    ///   - completion: completion block.
    func commitNavigation<ViewController, Context>(to step: DestinationStep<ViewController, Context>,
                                                   with context: Context,
                                                   animated: Bool,
                                                   completion: ((RoutingResult) -> Void)?) where ViewController: UIViewController {
        do {
            try navigate(to: step, with: context, animated: animated, completion: completion)
        } catch {
            completion?(.failure(error))
        }
    }

    /// Navigates the application to the view controller configured in `DestinationStep` with the `Context` set to `Any?`.
    /// Method does not throw errors, but propagates them to the completion block
    ///
    /// - Parameters:
    ///   - step: `DestinationStep` instance.
    ///   - animated: if true - the navigation should be animated where it is possible.
    ///   - completion: completion block.
    func commitNavigation<ViewController>(to step: DestinationStep<ViewController, Any?>,
                                          animated: Bool,
                                          completion: ((RoutingResult) -> Void)?) where ViewController: UIViewController {
        commitNavigation(to: step, with: nil, animated: animated, completion: completion)
    }

    /// Navigates the application to the view controller configured in `DestinationStep` with the `Context` set to `Void`.
    /// Method does not throw errors, but propagates them to the completion block
    ///
    /// - Parameters:
    ///   - step: `DestinationStep` instance.
    ///   - animated: if true - the navigation should be animated where it is possible.
    ///   - completion: completion block.
    func commitNavigation<ViewController>(to step: DestinationStep<ViewController, Void>,
                                          animated: Bool,
                                          completion: ((RoutingResult) -> Void)?) where ViewController: UIViewController {
        commitNavigation(to: step, with: (), animated: animated, completion: completion)
    }

}
