xquery version "3.0";

module namespace test = 'http://xokomola.com/xquery/tests';

declare %unit:test function test:pass() {
    unit:assert-equals(1,1)
};

declare %unit:test function test:fail() {
    unit:assert-equals(1,4)
};
