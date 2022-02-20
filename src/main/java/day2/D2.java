package day2;

public class D2 {
    public static void main(String[] args) {
        // download file
    }

    public enum Directions {
        D, L, R, U,
    }

    public static int calculateNextPin (Directions direction, int lastPin) {
        int newPin = 0;
        switch (direction) {
            case R -> {
                if (lastPin % 3 == 0) {
                    newPin = lastPin;
                } else {
                    newPin = lastPin + 1;
                }
            }
            case D -> {
                if (lastPin == 7 || lastPin == 8 || lastPin == 9) {
                    newPin = lastPin;
                } else {
                    newPin = lastPin + 3;
                }
            }
            case L -> {
                if (lastPin == 1 || lastPin == 4 || lastPin == 7) {
                    newPin = lastPin;
                } else {
                    newPin = lastPin -1;
                }
            }
            case U -> {
                if (lastPin >1 && lastPin < 4) {
                    newPin = lastPin;
                } else {
                    newPin = lastPin - 3;
                }
            }
        }
        return newPin;
    }
}
