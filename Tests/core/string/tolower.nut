//
//  core/string/tolower.nut
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
    describe(@"tolower", @{
        context("for ASCII strings", @{
            it("returns lowercase string", @{
                expect("Some String %$#@!".tolower()).to().equal("some string %$#@!");
                expect("CAPS".tolower()).to().equal("caps");
            });

            it("returns the same string for empty string", @{
                expect("".tolower()).to().equal("");
            });


            it("does not change numeric digits or symbols", @{
                expect("0123456789!@#$%^&*()_+".tolower()).to().equal("0123456789!@#$%^&*()_+");
            });
        });


        context("for Unicode strings (assuming Squirrel is compiled without wchar_t support)", @{
            // Assuming Squirrel is compiled without wchar_t support; I was not be able to make
            // it work under Mac OS X, which I'm currently using for testing
            it("returns incorrect values", @{
                expect("ЮНИКОД".tolower()).notTo().equal("юникод");
            });
        });
    });
});