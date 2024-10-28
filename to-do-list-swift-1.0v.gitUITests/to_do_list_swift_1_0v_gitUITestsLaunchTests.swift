//
//  to_do_list_swift_1_0v_gitUITestsLaunchTests.swift
//  to-do-list-swift-1.0v.gitUITests
//
//  Created by Turgut Alp on 29.10.2024.
//

import XCTest

final class to_do_list_swift_1_0v_gitUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
