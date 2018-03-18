# Reader
[![Carthage compatible][carthage-image]][carthage-url]

Reader monad in Swift, inspired by [implemention with Scala](https://gist.github.com/Mortimerp9/5384467).

## Overview
`Reader` is a wrapper for function that take some `Input` and produce `Element`.

```swift
// init(_:)
let reader = Reader<Int, Int> { $0 + 2 }

// execute(_:)
reader.execute(1) // 3
reader.execute(2) // 4

// map(_:)
reader
    .map { $0 * 2 }
    .execute(3) // 10

// flatMap(_:)
reader
    .flatMap { i1 in Reader<Int, Int> { i2 in i1 * i2 } }
    .execute(4) // 24
```

## :syringe:
Simple and static **Dependency Injection** is possible with `Reader`

example: [Playground](Examples/DependencyInjection.playground/Contents.swift)

## Installation

#### [Carthage](https://github.com/Carthage/Carthage)
Add following line into your Cartfile and run `carthage update`.

```shell
github "to4iki/Reader"
```

#### [SwiftPackage Manager](https://github.com/apple/swift-package-manager)
Add following line into your Package.swift and run `swift build`.

```swift
dependencies: [
    .Package(url: "https://github.com/to4iki/Reader.git", majorVersion: 0)
]
```

[carthage-url]: https://github.com/Carthage/Carthage
[carthage-image]: https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat
