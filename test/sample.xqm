xquery version '3.1';

module namespace test = 'example.test';

declare %unit:test function test:example() {
    unit:assert-equals(1,1)
};
