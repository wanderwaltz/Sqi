//
//  core/table/set.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 12.09.15.
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

SqTest.spec("table", @{
    describe("set", @{
        it("allows setting a value using the literal key", @{
            local table = { key = "value" };
            table.key = "qwerty";
            expect(table.key).to().equal("qwerty");
        });

        it("allows setting a value using the string key", @{
            local table = { key = "value" };
            table["key"] = "qwerty";
            expect(table["key"]).to().equal("qwerty");
        });

        it("throws an error if the key is not found", @{
            local table = {};
            expect(@()(table.qwerty = "asdfg")).to().throwError();
        });

        context("when having a delegate", @{
            it("invokes _set metamethod if available and key not found", @{
                local result = { invoked = false };
                local delegate = {};
                delegate._set <- function(index, value) { result.invoked = true; };

                local table = {};
                table.setdelegate(delegate);

                table["qwerty"] = 1234;
                expect(result.invoked).to().equal(true);
            });


            it("does not invoke _set metamethod if key is found", @{
                local result = { invoked = false };
                local delegate = {};
                delegate._set <- function(index, value) { result.invoked = true; };

                local table = {
                    asdfg = null
                };
                table.setdelegate(delegate);

                table.asdfg = "not invoked";
                expect(result.invoked).to().equal(false);
            });
        });
    });
});