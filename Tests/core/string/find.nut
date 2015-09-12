//
//  core/string/find.nut
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
    describe(@"find", @{
        it("returns the index of the first substring occurrence", @{
            expect("Hello, World!".find("World")).to().equal(7);
            expect("test".find("es")).to().equal(1);
            expect("test test".find("es")).to().equal(1);
            expect("test test test".find("es")).to().equal(1);
        });


        it("returns null if substring is not found", @{
            expect("test".find("qwerty")).to().equal(null);
        });


        it("returns zero if called with an empty argument string", @{
            expect("test".find("")).to().equal(0);
        });


        it("starts the search from the given index if present", @{
            expect("test".find("es", 4)).to().equal(null);
            expect("test test".find("es", 4)).to().equal(6);
            expect("test test test".find("es", 4)).to().equal(6);
        });


        it("always returns null if the second argument is equal or greater than the string length", @{
            expect("aaa".find("a", 3)).to().equal(null);
            expect("test".find("test", 50)).to().equal(null);
        });


        it("always returns null if starting index is negative", @{
            expect("test".find("t", -1)).to().equal(null);
            expect("test".find("t", -2)).to().equal(null);
            expect("test".find("t", -3)).to().equal(null);
            expect("test".find("t", -4)).to().equal(null);
            expect("aaaaaaaaaa".find("a", -4)).to().equal(null);
        });
    });
});