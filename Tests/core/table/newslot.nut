//
//  core/table/newslot.nut
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
    describe("newslot", @{
        it("allows setting a value using the literal key", @{
            local table = {};
            table.key <- "qwerty";
            expect(table.key).to().equal("qwerty");
        });

        it("allows setting a value using the string key", @{
            local table = {};
            table["key"] <- "qwerty";
            expect(table["key"]).to().equal("qwerty");
        });

        it("replaces the existing value if present", @{
            local table = { key = "value"};
            table.key <- "qwerty";
            expect(table.key).to().equal("qwerty");
        });

        context("when having a delegate", @{
            it("invokes _newslot metamethod if available", @{
                local result = { invoked_count = 0 };
                local delegate = {};
                delegate._newslot <- function(index, value) { result.invoked_count += 1; };

                local table = {};
                table.setdelegate(delegate);

                table["qwerty"] <- 1234;
                table["qwerty"] <- 4567;
                expect(result.invoked_count).to().equal(2);
            });
        });
    });
});