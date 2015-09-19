//
//  sqxtd/null/set.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 20.09.15.
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

SqTest.spec("null", @{
    requires("SQXTD_NULL_EXTENSION_VERSION", "0.0.1");
    // The spec for `null` is not true for vanilla Squirrel3, these properties
    // have been added by SqXtdLib and are possible with  changes to the
    // Squirrel language introduced in https://github.com/wanderwaltz/Squirrel
    // fork of the Squirrel language source.

    describe("set", @{
        // The goal was to make `null` behave more like Objective-C `nil` which
        // responds to any selector and returns `nil` back.

        it("does not throw when trying to set any value for any literal key", @{
            expect(@(){null.someKey = "qwerty";}).notTo().throwError();
            expect(@(){null.asdfg = false;}).notTo().throwError();
            expect(@(){null.zz = 15;}).notTo().throwError();
        });

        it("does not throw when trying to set any value for any string key", @{
            expect(@(){null["some string key"] = 123;}).notTo().throwError();
            expect(@(){null["abc"] = false;}).notTo().throwError();
            expect(@(){null[""] = {};}).notTo().throwError();
        });

        it("does not throw when trying to set any value for any integer key", @{
            expect(@(){null[456] = 123;}).notTo().throwError();
            expect(@(){null[-5] = false;}).notTo().throwError();
            expect(@(){null[0] = "abc";}).notTo().throwError();
        });

        it("does not throw when trying to set any value for any bool key", @{
            expect(@(){null[true] = 123;}).notTo().throwError();
            expect(@(){null[false] = false;}).notTo().throwError();
        });

        it("does not throw when trying to set any value for any array key", @{
            expect(@(){null[[4,5,6]] = 123;}).notTo().throwError();
            expect(@(){null[[]] = false;}).notTo().throwError();
            expect(@(){null[[1, "abc", false]] = "abc";}).notTo().throwError();
        });

        it("does not throw when trying to set any value for any table key", @{
            expect(@(){null[{}] = 123;}).notTo().throwError();
            expect(@(){null[{name="John Appleseed"}] = false;}).notTo().throwError();
        });

        it("does not throw when trying to set any value for any function key", @{
            expect(@(){null[@()false] = 123;}).notTo().throwError();
            expect(@(){null[@(x,y)x+y] = false;}).notTo().throwError();
            expect(@(){null[@(...){}] = "abc";}).notTo().throwError();
        });
    });
});