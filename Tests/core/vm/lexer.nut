//
//  core/vm/lexer.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 22.09.15.
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

SqTest.spec("vm", @{
    describe("lexer", @{
        requires("SQUIRREL_EXTENSIONS_VERSION", "0.0.1");

        it("supports ASCII identifiers", @{
            local variable = 123;
            local table = {
                key = "value"
            };

            expect(variable).to().equal(123);
            expect(table.key).to().equal("value");
        });


        it("supports non-ASCII identifiers", @{
            local переменная = 123; // 'переменная' == 'variable'
            local таблица = {       // 'таблица' == 'table'
                ключ = "value"      // 'ключ' == 'key'
            };

            local いろはにほへとちりぬるを = таблица;

            expect(переменная).to().equal(123);
            expect(таблица.ключ).to().equal("value");
            expect(いろはにほへとちりぬるを).to().equal(таблица);
        });


        it("supports bang '!' symbols in identifiers", @{
            local bang! = "qwerty";
            expect(bang!).to().equal("qwerty");
        });


        it("distinguishes identifiers with '!' symbols from != tokens", @{
            local bang! = "qwerty";
            bang! = 123;

            expect(bang!).to().equal(123);
            expect(bang! != 234).to().equal(true);
        });


        it("supports question mark '?' symbols in identifiers", @{
            local what? = "qwerty";
            expect(what?).to().equal("qwerty");
        });


        it("distinguishes identifiers with '?' symbols from ternary operator tokens", @{
            local what? = "qwerty";
            what? = true;

            expect(what?).to().equal(true);
            expect(what? ? "true" : "false").to().equal("true");
        });
    });
});