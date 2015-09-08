//
//  core/string/len.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 08.09.15.
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
    describe("len", @{
        context("for ASCII strings", @{
            it("returns the number of characters in the string", @{
                expect("".len()).to().equal(0);
                expect("one".len()).to().equal(3);
                expect("two".len()).to().equal(3);
                expect("three".len()).to().equal(5);
                expect("four".len()).to().equal(4);
            });
        });


        context("for Unicode strings", @{
            it("returns the number of SQChars needed to represent the string (SQChar == char || wchar_t)", @{
                // depends on which SQChar is used when compiling Squirrel,
                // cannot reliably test unicode now since I've no luck making
                // it work with wchar_t; adding a test here just to mention
                // that Unicode may not be supported.
                expect("юникод".len()).to().beNoLessThan(6);
            });
        });
    });
});