//
//  utf8/string/at.nut
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
    requires("SQUTF8_STRING_EXTENSION_VERSION", "0.0.1");

    describe("at", @{
        it("returns the string containing a single UTF-8 code point at the given index", @{
            expect("юникод".at(0)).to().equal("ю");
            expect("юникод".at(1)).to().equal("н");
            expect("юникод".at(2)).to().equal("и");
            expect("юникод".at(3)).to().equal("к");
            expect("юникод".at(4)).to().equal("о");
            expect("юникод".at(5)).to().equal("д");

            expect("いろはにほへとちりぬるを".at(0)).to().equal("い");
            expect("いろはにほへとちりぬるを".at(1)).to().equal("ろ");
            expect("いろはにほへとちりぬるを".at(2)).to().equal("は");
            expect("いろはにほへとちりぬるを".at(3)).to().equal("に");
            expect("いろはにほへとちりぬるを".at(4)).to().equal("ほ");
            expect("いろはにほへとちりぬるを".at(5)).to().equal("へ");
            expect("いろはにほへとちりぬるを".at(6)).to().equal("と");
            expect("いろはにほへとちりぬるを".at(7)).to().equal("ち");
            expect("いろはにほへとちりぬるを".at(8)).to().equal("り");
            expect("いろはにほへとちりぬるを".at(9)).to().equal("ぬ");
            expect("いろはにほへとちりぬるを".at(10)).to().equal("る");
            expect("いろはにほへとちりぬるを".at(11)).to().equal("を");
        });

        it("returns null if index is greater than the string length", @{
            expect("юникод".at(6)).to().equal(null);
            expect("юникод".at(1235)).to().equal(null);
            expect("いろはにほへとちりぬるを".at(999)).to().equal(null);
        });

        it("counts indexes backwards from the end of the string for negative indexes", @{
            expect("юникод".at(-1)).to().equal("д");
            expect("юникод".at(-2)).to().equal("о");
            expect("юникод".at(-3)).to().equal("к");
            expect("юникод".at(-4)).to().equal("и");
            expect("юникод".at(-5)).to().equal("н");
            expect("юникод".at(-6)).to().equal("ю");

            expect("いろはにほへとちりぬるを".at(-12)).to().equal("い");
            expect("いろはにほへとちりぬるを".at(-11)).to().equal("ろ");
            expect("いろはにほへとちりぬるを".at(-10)).to().equal("は");
            expect("いろはにほへとちりぬるを".at(-9)).to().equal("に");
            expect("いろはにほへとちりぬるを".at(-8)).to().equal("ほ");
            expect("いろはにほへとちりぬるを".at(-7)).to().equal("へ");
            expect("いろはにほへとちりぬるを".at(-6)).to().equal("と");
            expect("いろはにほへとちりぬるを".at(-5)).to().equal("ち");
            expect("いろはにほへとちりぬるを".at(-4)).to().equal("り");
            expect("いろはにほへとちりぬるを".at(-3)).to().equal("ぬ");
            expect("いろはにほへとちりぬるを".at(-2)).to().equal("る");
            expect("いろはにほへとちりぬるを".at(-1)).to().equal("を");
        });

        it("returns null for negative indexes out of bounds", @{
            expect("юникод".at(-7)).to().equal(null);
            expect("юникод".at(-1235)).to().equal(null);
            expect("いろはにほへとちりぬるを".at(-999)).to().equal(null);
        });
    });
});
