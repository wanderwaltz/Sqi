//
//  sqxtd/string/components_separated_by_string.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 16.09.15.
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

SqTest.spec("string", @{
    requires("SQXTD_STRING_EXTENSION_VERSION", "0.0.1");
    // The spec for string utility functions is not true for vanilla Squirrel3,
    // this functionality have been added by SqXtdLib and is possible with
    // changes to the Squirrel language introduced in
    // https://github.com/wanderwaltz/Squirrel fork of the Squirrel language source.

    describe("componentsSeparatedByString", @{
        it("returns an array", @{
            expect(typeof("a,b,c".componentsSeparatedByString(","))).to().equal(typeof([]));
        });


        it("returns an array of strings", @{
            local array = "a,b,c".componentsSeparatedByString(",");

            foreach (i, s in array) {
                expect(typeof(s)).to().equal(typeof(""));
            }
        });


        it("returns substrings separated by the given string", @{
            expect("a,b,c".componentsSeparatedByString(",")).to().equal(["a","b","c"]);
        });


        it("supports multi-char separators", @{
            expect("a---b---c".componentsSeparatedByString("---")).to().equal(["a","b","c"]);
        });


        it("returns a single component if separator is not present in string", @{
            expect("abc".componentsSeparatedByString(",")).to().equal(["abc"]);
        });


        it("keeps empty components", @{
            expect("a,,b,c".componentsSeparatedByString(",")).to().equal(["a","","b","c"]);
        });


        it("throws an error if called with a non-string parameter", @{
            expect(@()"a,b,c".componentsSeparatedByString(1)).to().throwError();
        });
    });
});
