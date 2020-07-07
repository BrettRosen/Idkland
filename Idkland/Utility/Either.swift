//
//  Either.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import Foundation

public enum Either<L, R> {
    case left(L)
    case right(R)
}

extension Either {
    public func either<A>(_ l2a: (L) throws -> A, _ r2a: (R) -> A) rethrows -> A {
        switch self {
        case let .left(l):
            return try l2a(l)
        case let .right(r):
            return r2a(r)
        }
    }
    
    public var left: L? {
        return either(Optional.some, const(.none))
    }
    
    public var right: R? {
        return either(const(.none), Optional.some)
    }
    
    public var isLeft: Bool {
        return either(const(true), const(false))
    }
    
    public var isRight: Bool {
        return either(const(false), const(true))
    }
}

public func const<A, B>(_ a: A) -> (B) -> A {
    return { _ in a }
}
