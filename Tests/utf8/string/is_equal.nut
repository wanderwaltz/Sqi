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

    describe("isEqual", @{
        it("compares strings for equality", @{
            expect("юникод".isEqual("юникод")).to().equal(true);
            expect("юникод".isEqual("いろはにほへとちりぬるを")).to().equal(false);
        });

        // Not yet
        //
        // it("uses the normalized form for string comparison", @{
        //     expect("à".isEqual("à")).to().equal(true);
        //     expect("é".isEqual("é")).to().equal(true);
        //     expect("õ".isEqual("õ")).to().equal(true);
        //     expect("ă".isEqual("ă")).to().equal(true);
        //     expect("ė".isEqual("ė")).to().equal(true);
        //     expect("ï".isEqual("ï")).to().equal(true);
        //     expect("å".isEqual("å")).to().equal(true);
        // });
    });
});
