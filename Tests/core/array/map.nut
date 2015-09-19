//
//  core/array/map.nut
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

SqTest.spec("array", @{
    describe("map", @{
        it("returns a new array with elements returned by the map function provided", @{
            expect([1,2,3].map(@(x)"qwerty")).to().equal(["qwerty", "qwerty", "qwerty"]);
            expect([1,2,3].map(@(x)x*x)).to().equal([1,4,9]);
            expect(["one", "two", "three"].map(@(x)x.len())).to().equal([3,3,5]);
        });

        it("returns a new array with mapped elements", @{
            local initial_array = [1,2,3];
            local expected_array = [2,4,6];
            local mapped_array = initial_array.map(@(x)x*2);

            foreach (i, x in mapped_array) {
                expect(x).to().equal(expected_array[i]);
            }
        });

        it("receives itself as an implicit `this` parameter to map function", @{
            local actual = {
                parameter = null
            };

            local array = [1,2,3];

            array.map(@(x)(actual.parameter = this));

            expect(actual.parameter).to().equal(array);
        });

        it("throws error if mapping function parameter count is not 1", @{
            expect(@()[1,2,3].map(@()"qwerty")).to().throwError();
            expect(@()[1,2,3].map(@(a,b)"qwerty")).to().throwError();

            expect(@()[1,2,3].map(@(x)"qwerty")).notTo().throwError();
        });

        it("trows error if called with a non-function parameter", @{
            expect(@()[1,2,3].map(null)).to().throwError();
            expect(@()[1,2,3].map(123)).to().throwError();
            expect(@()[1,2,3].map("qwerty")).to().throwError();
            expect(@()[1,2,3].map(false)).to().throwError();
        });
    });
});