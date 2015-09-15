//
//  core/string/literal.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 15.09.15.
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
    describe(@"literal", @{
        it("returns string", @{
            expect("qwerty").to().equal("qwerty");
        });

        it("allows Unicode strings", @{
            expect(typeof("いろはにほへとちりぬるを")).to().equal(typeof("any string"));
            expect("いろはにほへとちりぬるを").to().equal("いろはにほへとちりぬるを");
        });

        it("allows hexadecimal character codes", @{
            expect("\xF0\x9D\x84\x9E").to().equal("𝄞");
            expect("\xE2\x9D\xA4").to().equal("❤");
            expect("\xE2\x98\xAD").to().equal("☭");
            expect("\xE2\x99\xAB").to().equal("♫");
        });

        context("when parsing several consecutive string literals", @{
            requires("SQUIRREL_EXTENSIONS_VERSION", "0.0.1");

            it("concatenates the consequtive string literals into a single string", @{
                expect("qwerty" "asdfg").to().equal("qwertyasdfg");
                expect("first line\n"
                       "second line").to().equal("first line\nsecond line");
            });
        });
    });
});