package day1;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class D1Test {

    @Test
    void turnToTest() {
        assertEquals(D1.Directions.E, D1.turnTo(D1.Directions.N, D1.Turns.R));
        assertEquals(D1.Directions.N, D1.turnTo(D1.Directions.W, D1.Turns.R));
        assertEquals(D1.Directions.W, D1.turnTo(D1.Directions.N, D1.Turns.L));
        assertEquals(D1.Directions.S, D1.turnTo(D1.Directions.E, D1.Turns.R));
    }

    @Test
    void calculateDistance() {
    }
}