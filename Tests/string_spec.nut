//
//  string_spec.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 05.09.15.
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

SqTest.spec("string", function(){
    // The spec for string utility functions conversion is not true for vanilla Squirrel3,
    // this functionality have been added by SqXtdLib and is possible with
    // changes to the Squirrel language introduced in
    // https://github.com/wanderwaltz/Squirrel fork of the Squirrel language source.

    describe("componentsSeparatedByString", function(){
        it("should return an array", function(){
            expect(typeof("a,b,c".componentsSeparatedByString(","))).to().equal(typeof([]));
        });


        it("should return an array of strings", function(){
            local array = "a,b,c".componentsSeparatedByString(",");

            foreach (i, s in array) {
                expect(typeof(s)).to().equal(typeof(""));
            }
        });


        it("should return substrings separated by the given string", function(){
            expect("a,b,c".componentsSeparatedByString(",")).to().equal(["a","b","c"]);
        });


        it("should support multi-char separators", function(){
            expect("a---b---c".componentsSeparatedByString("---")).to().equal(["a","b","c"]);
        });


        it("should return a single component if separator is not present in string", function(){
            expect("abc".componentsSeparatedByString(",")).to().equal(["abc"]);
        });


        it("should keep empty components", function(){
            expect("a,,b,c".componentsSeparatedByString(",")).to().equal(["a","","b","c"]);
        });


        it("should throw if called with a non-string parameter", function(){
            expect(@()"a,b,c".componentsSeparatedByString(1)).to().throwError();
        });
    });
});
