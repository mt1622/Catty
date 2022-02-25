/**
 *  Copyright (C) 2010-2022 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import XCTest

@testable import Pocket_Code

class IndexOfItemFunctionTest: XCTestCase {

    var function: IndexOfItemFunction!

    override func setUp() {
        super.setUp()
        function = IndexOfItemFunction()
    }

    override func tearDown() {
        function = nil
        super.tearDown()
    }

    func testDefaultValue() {
        XCTAssertEqual(type(of: function).defaultValue, function.value(firstParameter: "invalidParameter" as AnyObject, secondParameter: "list name" as AnyObject), accuracy: Double.epsilon)
        XCTAssertEqual(type(of: function).defaultValue, function.value(firstParameter: 100 as AnyObject, secondParameter: 2 as AnyObject), accuracy: Double.epsilon)
        XCTAssertEqual(type(of: function).defaultValue, function.value(firstParameter: nil, secondParameter: nil), accuracy: Double.epsilon)

        let userVariable = UserList(name: "testName")

        XCTAssertEqual(type(of: function).defaultValue, function.value(firstParameter: 1 as AnyObject, secondParameter: userVariable as AnyObject), accuracy: Double.epsilon)
    }

    func testValue() {
        // number list
        let userListNumber = UserList(name: "myListNumber")
        userListNumber.add(element: 5)
        userListNumber.add(element: 3.5)
        userListNumber.add(element: 1)
        userListNumber.add(element: 0)

        XCTAssertEqual(3.0, function.value(firstParameter: 1 as AnyObject, secondParameter: userListNumber), accuracy: Double.epsilon)
        XCTAssertEqual(0.0, function.value(firstParameter: 9 as AnyObject, secondParameter: userListNumber), accuracy: Double.epsilon)

        // string list
        let userListString = UserList(name: "myListString")
        userListString.add(element: "今日は")
        userListString.add(element: "abc")

        XCTAssertEqual(2.0, function.value(firstParameter: "abc" as AnyObject, secondParameter: userListString), accuracy: Double.epsilon)
        XCTAssertEqual(0.0, function.value(firstParameter: "ab" as AnyObject, secondParameter: userListString), accuracy: Double.epsilon)
    }

    func testFirstParameter() {
        XCTAssertEqual(.number(defaultValue: 1), function.firstParameter())
    }

    func testSecondParameter() {
        XCTAssertEqual(.list(defaultValue: "list name"), function.secondParameter())
    }

    func testTag() {
        XCTAssertEqual("INDEX_OF_ITEM", type(of: function).tag)
    }

    func testName() {
        XCTAssertEqual(kUIFEFunctionIndexOfItem, type(of: function).name)
    }

    func testRequiredResources() {
        XCTAssertEqual(ResourceType.noResources, type(of: function).requiredResource)
    }

    func testIsIdempotent() {
        XCTAssertFalse(type(of: function).isIdempotent)
    }

    func testFormulaEditorSections() {
        let sections = function.formulaEditorSections()
        XCTAssertEqual(1, sections.count)
        XCTAssertEqual(.functions(position: type(of: function).position, subsection: .lists), sections.first)
    }
}
