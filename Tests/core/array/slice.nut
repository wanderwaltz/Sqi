//
//  core/array/slice.nut
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
    describe("slice", @{
        it("returns a section of the array as a new array", @{
            expect([1,2,3,4,5,6,7,8,9,0].slice(0,5)).to().equal([1,2,3,4,5]);
            expect([1,2,3,4,5,6,7,8,9,0].slice(1,4)).to().equal([2,3,4]);
        });

        context("if the second argument is omitted", @{
            it("returns the same array if the argument is zero", @{
                expect([1,2,3].slice(0)).to().equal([1,2,3]);
            });

            it("returns a new instance of the array if the argument is zero", @{
                local array = [1,2,3];
                local sliced = array.slice(0);
                expect(sliced).notTo().beIdenticalTo(array);

                sliced[0] = 5;
                expect(array[0]).to().equal(1);
            });

            it("returns an empty array if the argument is equal to array length", @{
                expect([1,2,3].slice(3)).to().equal([]);
            });

            it("copies from the starting index to the end of the array", @{
                expect([1,2,3,4].slice(2)).to().equal([3,4]);
            });

            it("throws an error if starting index is greater than the array length", @{
                expect(@()[1,2,3].slice(5)).to().throwError();
                expect(@()[1,2,3].slice(123)).to().throwError();
            });

            context("if the argument is negative", @{
                it("copies from length+index to the end of the array", @{
                    expect([1,2,3,4].slice(-2)).to().equal([3,4]);
                });

                it("returns the same array if the argument is equal to -array.len()", @{
                    expect([1,2,3,4].slice(-4)).to().equal([1,2,3,4]);
                });

                it("returns a new instance of the array if the argument is equal to -array.len()", @{
                    local array = [1,2,3,4];
                    local sliced = array.slice(-4);
                    expect(sliced).notTo().beIdenticalTo(array);

                    sliced[0] = 100500;
                    expect(array[0]).to().equal(1);
                });
            });
        });

        context("if both arguments are present", @{
            it("copies from the start index to the end index not including it", @{
                expect([1,2,3,4,5,6].slice(1,2)).to().equal([2]);
            });

            it("returns an empty array if the start index is equal to the end index", @{
                expect([1,2,3,4,5,6].slice(3,3)).to().equal([]);
            });

            it("throws an error if the end index is less than the start index", @{
                expect(@()[1,2,3,4,5,6].slice(3,2)).to().throwError();
            });

            context("if the first argument is negative", @{
                it("copies from length+index to the end index not including it", @{
                    expect([1,2,3,4,5,6].slice(-3, 5)).to().equal([4,5]);
                });

                it("copies from the first index if the argument is equal to -array.len()", @{
                    expect([1,2,3,4].slice(-4, 3)).to().equal([1,2,3]);
                });
            });

            context("if the second argument is negative", @{
                it("copies from the start index to length+end not including it", @{
                    expect([1,2,3,4,5,6].slice(2, -2)).to().equal([3,4]);
                });

                it("returns an empty array if start == length+end", @{
                    expect([1,2,3,4,5,6].slice(4,-2)).to().equal([]);
                });

                it("throws an error if length+end is less than start", @{
                    expect(@()[1,2,3,4,5,6].slice(4,-4)).to().throwError();
                });
            });

            context("if both arguments are negative", @{
                it("copies from the length+start to length+end not including it", @{
                    expect([1,2,3,4,5,6].slice(-4, -2)).to().equal([3,4]);
                });

                it("returns an empty array if start == end", @{
                    expect([1,2,3,4,5].slice(-2,-2)).to().equal([]);
                });

                it("throws an error if end is less than start", @{
                    expect(@()[1,2,3,4,5,6].slice(-2,-3)).to().throwError();
                });
            });
        });
    });
});
