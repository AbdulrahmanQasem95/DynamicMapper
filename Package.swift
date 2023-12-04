// swift-tools-version:5.0
//  package.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//
import PackageDescription

let package = Package(
    name: "DynamicMapper",
    platforms: [.macOS(.v10_13),
                .iOS(.v11),
                .tvOS(.v11),
                .watchOS(.v4)],
    products: [.library(name: "DynamicMapper",
                        targets: ["DynamicMapper"])],
    targets: [
        .target(
            name: "DynamicMapper",
            path: "Classes")
    ],
    swiftLanguageVersions: [.v5]
)
