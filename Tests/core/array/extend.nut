//
//  core/array/extend.nut
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

SqTest.spec("array", @{
    describe("extend", @{
        it("appends all elements from the parameter array into the receiver", @{
            local array = [1, 2];
            local other = [3, 4, 5];

            array.extend(other);
            expect(array).to().equal([1,2,3,4,5]);
        });

        it("does not alter the parameter array", @{
            local array = [3, 4, 5];
            [1,2].extend(array);
            expect(array).to().equal([3,4,5]);
        });

        it("returns null (mutates receiver in-place)", @{
            expect([1,2].extend([3,4,5])).to().equal(null);
        });

        it("correctly resizes the array", @{
            local array = [1, 2];
            expect(array.len()).to().equal(2);

            array.extend([3,4,5]);
            expect(array.len()).to().equal(5);

            array.extend([6,7]);
            expect(array.len()).to().equal(7);
        });

        it("properly handles calls with self as the parameter", @{
            local array = [1, 2, 3, 4, 5, 6];
            array.extend(array);

            expect(array).to().equal([1,2,3,4,5,6,1,2,3,4,5,6]);
        });

        it("properly handles recursive arrays", @{
            local empty = []; empty.append(empty);
            expect(empty.len()).to().equal(1);

            empty.extend(empty);
            expect(empty.len()).to().equal(2);


            local recursive_array = [1, "abc", 3.0];
            for (local i = 0; i < 5; ++i) {
                recursive_array.append(recursive_array);
            }
            expect(recursive_array.len()).to().equal(8);

            recursive_array.extend(recursive_array);
            expect(recursive_array.len()).to().equal(16);
        });

        it("throws an error if the parameter is not an array", @{
            expect(@()[].extend(1)).to().throwError();
            expect(@()[].extend(false)).to().throwError();
            expect(@()[].extend("qwerty")).to().throwError();
        });
    });
});
