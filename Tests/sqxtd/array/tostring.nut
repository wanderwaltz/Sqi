//
//  tostring.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 07.09.15.
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

SqTest.spec("array", @{
    context("when converted to string", @{
        requires("SQXTD_DEFAULT_TOSTRING_REPRESENTATIONS_EXTENSION_VERSION", "0.0.1");
        // The spec for arrays tostring conversion is not true for vanilla Squirrel3,
        // this functionality have been added by SqXtdLib and are possible with
        // changes to the Squirrel language introduced in
        // https://github.com/wanderwaltz/Squirrel fork of the Squirrel language source.

        it("lists all array's elements", @{
            expect([1,2,3].tostring()).to().equal("[1, 2, 3]");
        });

        it("puts strings inside the array into double quotes", @{
            expect(["qwerty", "asdfg"].tostring()).to().equal("[\"qwerty\", \"asdfg\"]");
        });

        it("does not break on recursive arrays", @{
            expect(typeof(ArraySpecs.empty_recursive().tostring())).to().equal(typeof(""));
            expect(typeof(ArraySpecs.recursive().tostring())).to().equal(typeof(""));
        });
    });
});
