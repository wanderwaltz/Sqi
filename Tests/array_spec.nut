//
//  array_spec.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 06.09.15.
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

SqTest.spec("array", @(){
    // The spec for array utility functions conversion is not true for vanilla Squirrel3,
    // this functionality have been added by SqXtdLib and is possible with
    // changes to the Squirrel language introduced in
    // https://github.com/wanderwaltz/Squirrel fork of the Squirrel language source.

    describe("componentsJoinedByString", @(){
        it("should return a string", @(){
            expect(typeof([1,2,3].componentsJoinedByString(","))).to().equal(typeof(""));
        });


        it("should join string representations of array elements with the given string", @(){
            expect([1,2,3].componentsJoinedByString(", ")).to().equal("1, 2, 3");
        });


        it("should return an empty string for an empty array", @(){
            expect([].componentsJoinedByString(",")).to().equal("");
        });


        it("should throw if the parameter is not a string", @(){
            expect(@()[1,2,3].componentsJoinedByString(1)).to().throwError();
        });
    });
});
