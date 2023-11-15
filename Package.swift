//
//  package.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//
import PackageDescription

let package = Package(
    name: "DynamicMapper",
    platforms: [.macOS(.v10_10),
                .iOS(.v12),
                .tvOS(.v9),
                .watchOS(.v2)],
    products: [.library(name: "DynamicMapper",
                        targets: ["DynamicMapper"])],
    targets: [
        .target(
            name: "DynamicMapper",
            path: "Classes")
    ],
    swiftLanguageVersions: [.v5]
)
