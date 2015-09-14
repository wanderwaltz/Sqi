//
//  core/table/get.nut
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
    describe("get", @{
        it("allows reading a value using the literal key it was created with", @{
            local table = { key = "value" };
            expect(table.key).to().equal("value");
        });

        it("allows reading a value using the string key it was created with", @{
            local table = { key = "value" };
            expect(table["key"]).to().equal("value");
        });

        it("throws an error if the key is not found", @{
            local table = {};
            expect(@()table["qwerty"]).to().throwError();
        });

        it("returns the referenced object for stored weakrefs", @{
            local table = {};
            local string = "qwerty";
            local weakString = string.weakref();

            table.asdfg <- weakString;
            expect(typeof(weakString)).to().equal(typeof(getroottable().weakref()));
            expect(typeof(table.asdfg)).to().equal(typeof(string));
            expect(typeof(table.asdfg)).notTo().equal(typeof(weakString));
            expect(table.asdfg).to().equal(string);
        });

        context("when having a delegate", @{
            it("invokes _get metamethod if available and key not found", @{
                local delegate = {};
                delegate._get <- function(index) { return "invoked"; };

                local table = {};
                table.setdelegate(delegate);

                expect(table["qwerty"]).to().equal("invoked");
            });


            it("does not invoke _get metamethod if key is found", @{
                local delegate = {};
                delegate._get <- function(index) { return "invoked"; };

                local table = {
                    asdfg = "not invoked"
                };
                table.setdelegate(delegate);

                expect(table["asdfg"]).to().equal("not invoked");
            });
        });
    });
});