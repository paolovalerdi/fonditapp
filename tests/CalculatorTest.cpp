#include "catch.hpp"
#include "Calculator.h"

TEST_CASE("Sum functions testing") {
    Calculator calculator;
    REQUIRE(calculator.sum(1, 8) == 9);
    REQUIRE(calculator.sum(8, 5) == 13);
    REQUIRE(calculator.sum(2, 43) == 45);
    REQUIRE(calculator.sum(61, 12) == 73);
}
