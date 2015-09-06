//
//  getters_setters_spec.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 03.09.15.
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

SqTest.spec("getters/setters", @(){
    describe("tables", @(){
        it("should allow reading a value using the literal key it was created with", @(){
            local table = { key = "value" };
            expect(table.key).to().equal("value");
        });

        it("should allow reading a value using the string key it was created with", @(){
            local table = { key = "value" };
            expect(table["key"]).to().equal("value");
        });
    });

    describe("null", @(){
        // The spec for `null` is not true for vanilla Squirrel3, these properties
        // have been added by SqXtdLib and are possible with  changes to the
        // Squirrel language introduced in https://github.com/wanderwaltz/Squirrel
        // fork of the Squirrel language source.

        context("when indexing", @(){
            it("should allow getting a null value for any literal key",
                @() expect(null.someKey).to().equal(null));

            it("should allow getting a null value for any string key",
                @() expect(null["some string key"]).to().equal(null));

            it("should allow getting a null value for any integer key",
                @() expect(null[123]).to().equal(null));
        });

        context("when setting values", @(){
            it("should allow setting a value for any key",
                // the return value of (a = b) expression is b
                @() expect((null.key = "value")).to().equal("value"));
        });
    });
});