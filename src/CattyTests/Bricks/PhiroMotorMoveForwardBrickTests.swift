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

final class PhiroMotorMoveForwardBrickTests: AbstractBrickTest {

    var brick: PhiroMotorMoveForwardBrick!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.set(true, forKey: kUsePhiroBricks)
        brick = PhiroMotorMoveForwardBrick()
        let script = Script()
        let object = SpriteObject()
        let scene = Scene()

        object.scene = scene
        script.object = object
        brick.script = script
    }

    override func tearDown() {
        UserDefaults.standard.set(false, forKey: kUsePhiroBricks)
        super.tearDown()
    }

    func testGetFormulas() {
        brick.formula = Formula(integer: 1)
        var formulas = brick.getFormulas()

        XCTAssertEqual(formulas?.count, 1)
        XCTAssertEqual(brick.formula, formulas?[0])

        brick.formula = Formula(integer: 22)
        formulas = brick.getFormulas()

        XCTAssertEqual(brick.formula, formulas?[0])
     }
}
