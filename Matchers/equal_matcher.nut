//
//  equal_matcher.nut
//  SqTest
//
//  Created by Egor Chiglintsev on 13.08.15.
//  Copyright (c) 2015  Egor Chiglintsev
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

class Matchers.Equal extends Matchers.Base {
    expectedValue = null

    constructor(what) {
        expectedValue = what
    }

    function match(value) {
        return base.match(value) || isEqual(expectedValue, value);
    }

    function isEqual(a, b) {
        local equal = (a == b);

        // isEqual is optionally added by SqXtdLib and
        // checks arrays/tables equality memberwise
        if (!equal) {
            try {
                equal = a.isEqual(b);
            }
            catch(error) {
            }
        }

        if (!equal) {
            try {
                equal = b.isEqual(a);
            }
            catch(error) {
            }
        }

        return equal;
    }

    function description() {
        return actualValue + " == " + expectedValue;
    }
}