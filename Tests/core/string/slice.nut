//
//  core/string/slice.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 09.09.15.
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
    describe("slice", @{
        it("returns a section of the string as new string", @{
            expect("Hello, World!".slice(0,5)).to().equal("Hello");
            expect("Hello, World!".slice(1,4)).to().equal("ell");
        });

        context("if the second argument is omitted", @{
            it("returns the string itself if the argument is zero", @{
                expect("test".slice(0)).to().equal("test");
            });

            it("returns an empty string if the argument is equal to string length", @{
                expect("test".slice(4)).to().equal("");
            });

            it("copies from the starting index to the end of the string", @{
                expect("Hello, World!".slice(2)).to().equal("llo, World!");
            });

            it("throws an error if starting index is greater than the string length", @{
                expect(@()"test".slice(5)).to().throwError();
                expect(@()"test".slice(123)).to().throwError();
            });

            context("if the argument is negative", @{
                it("copies from length+index to the end of the string", @{
                    expect("Hello, World!".slice(-6)).to().equal("World!");
                });

                it("returns the string itself if the argument is equal to -string.len()", @{
                    expect("test".slice(-4)).to().equal("test");
                });
            });
        });

        context("if both arguments are present", @{
            it("copies from the start index to the end index not including it", @{
                expect("asdfg".slice(1,2)).to().equal("s");
            });

            it("returns an empty string if the start index is equal to the end index", @{
                expect("asdfg".slice(3,3)).to().equal("");
            });

            it("throws an error if the end index is less than the start index", @{
                expect(@()"asdfg".slice(3,2)).to().throwError();
            });

            context("if the first argument is negative", @{
                it("copies from length+index to the end index not including it", @{
                    expect("qwerty".slice(-3, 5)).to().equal("rt");
                });


                it("copies from the first index if the argument is equal to -string.len()", @{
                    expect("test".slice(-4, 3)).to().equal("tes");
                });
            });

            context("if the second argument is negative", @{
                it("copies from the start index to length+end not including it", @{
                    expect("qwerty".slice(2, -2)).to().equal("er");
                });

                it("returns an empty string if start == length+end", @{
                    expect("qwerty".slice(4,-2)).to().equal("");
                });

                it("throws an error if length+end is less than start", @{
                    expect(@()"qwerty".slice(4,-4)).to().throwError();
                });
            });

            context("if both arguments are negative", @{
                it("copies from the length+starto to length+end not including it", @{
                    expect("qwerty".slice(-4, -2)).to().equal("er");
                });

                it("returns an empty string if start == end", @{
                    expect("qwerty".slice(-2,-2)).to().equal("");
                });

                it("throws an error if end is less than start", @{
                    expect(@()"qwerty".slice(-2,-3)).to().throwError();
                });
            });
        });
    });
});